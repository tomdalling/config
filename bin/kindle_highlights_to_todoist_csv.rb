#!/usr/bin/env ruby

require 'pathname'
require 'time'
require 'csv'

def help
  puts <<~END_HELP
    Usage: #{$0} <path_to_clippings_txt> [book_query] [renamed_book]

      <path_to_clippings_txt>
        The path the to "My Clippings.txt" file from the Kindle

      [book_query]
        Optional. If given, will only output highlights from books that include
        the given string.

      [renamed_book]
        Optional. If given, output will use this as the name of the book.
  END_HELP
  abort
end

INPUT_PATH = ARGV[0] && Pathname(ARGV[0])
BOOK_QUERY = ARGV[1]
BOOK_RENAME = ARGV[2]
help unless INPUT_PATH && INPUT_PATH.file?

META_REGEX = %r{
  \A # start of string
  -\sYour\sHighlight\son\spage\s(?<page>\d+)
  \s\|\s
  location\s(?<loc_start>\d+)-(?<loc_end>\d+)
  \s\|\s
  Added\son\s(?<added_on>.+)
  \z # end of string
}x

META_REGEX2 = %r{
  \A # start of string
  -\sYour\sHighlight\sat\slocation\s(?<loc_start>\d+)-(?<loc_end>\d+)
  \s\|\s
  Added\son\s(?<added_on>.+)
  \z # end of string
}x

def main
  clippings = clippings_from(INPUT_PATH)
  write_clippings_as_csv(clippings)
end

def clippings_from(path)
  INPUT_PATH.read(encoding: 'bom|utf-8')
    .gsub(/\r\n?/, "\n")
    .split(/^=+$/)
    .map(&:strip)
    .select { _1.include?("- Your Highlight") }
    .map { parse_clipping(_1) }
    .select { clipping_has_valid_book?(_1) }
    .map { rename_book(_1) }
end

def parse_clipping(clipping)
  book, meta, *quote = clipping.lines
  meta_match = meta.strip.then { _1.match(META_REGEX) || _1.match(META_REGEX2) }
  unless meta_match
    raise "Can't parse clipping meta info: #{meta.strip}"
  end

  captures = meta_match
    .named_captures
    .map { [_1.to_sym, _2] }
    .to_h || {}

  xform_key(captures, :page) { Integer(_1) }
  xform_key(captures, :loc_start) { Integer(_1) }
  xform_key(captures, :loc_end) { Integer(_1) }
  xform_key(captures, :added_on) { Time.parse(_1) }

  {
    book: book.strip,
    quote: quote.join.strip,
    **captures,
  }
end

def clipping_has_valid_book?(clipping)
  if BOOK_QUERY
    clipping.fetch(:book).include?(BOOK_QUERY)
  else
    true
  end
end

def rename_book(clipping)
  if BOOK_RENAME
    clipping.merge(book: BOOK_RENAME)
  else
    clipping
  end
end

def xform_key(hash, key)
  value = hash[key]
  if value
    hash[key] = yield(value)
  end
  nil
end

def trunc(str)
  max_len = 60
  elip = "\u2026"
  if str.length > max_len
    str.slice(0, max_len - elip.length) + elip
  else
    str
  end
end

def word_wrap(text, max_len:, prefix: '', suffix: '')
  words = text.split
  lines = []
  max_inner_len = max_len - prefix.length - suffix.length

  until words.empty?
    next_word = words.shift
    added_to_last = (lines.last || '') + ' ' + next_word
    if !lines.empty? && added_to_last.length <= max_inner_len
      lines[-1] = added_to_last
    else
      lines[-1] += suffix unless lines.empty?
      lines << prefix + next_word # new line
    end
  end

  lines[-1] += suffix unless lines.empty?
  lines.join("\n")
end

def row_for_full_clipping(c)
  block_quote = word_wrap(c.fetch(:quote), max_len: 80, prefix: '> ')
  citation = [
    "Book: " + c.fetch(:book),
    c[:page] ? "Page: #{c[:page]}" : "Location: #{c.fetch(:loc_start)}-#{c.fetch(:loc_end)}",
    "Accessed: #{c.fetch(:added_on).iso8601}",
  ].join("\n")

  {
    TYPE: 'note',
    CONTENT: block_quote + "\n\n" + citation,
  }
end

def row_for_short_clipping(c)
  {
    TYPE: 'task',
    CONTENT: 'Quote: ' + trunc(c.fetch(:quote)),
    INDENT: 2,
    PRIORITY: '4',
  }
end

def row_for_book(book)
  {
    TYPE: 'task',
    CONTENT: "Highlights for book: #{book}",
    INDENT: 1,
    PRIORITY: '4',
  }
end

def write_clippings_as_csv(all_clippings)
  headings = [:TYPE, :INDENT, :PRIORITY, :CONTENT]
  csv = CSV.new(STDOUT)

  csv << headings
  all_clippings.group_by{ _1.fetch(:book) }.each do |book, book_clippings|
    csv << row_for_book(book).values_at(*headings)
    book_clippings.each do |c|
      csv << row_for_short_clipping(c).values_at(*headings)
      csv << row_for_full_clipping(c).values_at(*headings)
    end
  end
end

main
