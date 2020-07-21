#!/usr/bin/env ruby

require 'pathname'
require 'time'
require 'csv'
require 'bundler/inline'
gemfile do
  gem 'dry-cli', '0.6.0'
end

DEFAULT_CLIPPINGS_PATH = "/Volumes/Kindle/documents/My Clippings.txt"

class Command < Dry::CLI::Command
  desc <<~END_DESC
    Takes highlights from a Kindle 'My Clippings.txt' file outputs them in
    Todoist-compatible CSV format.
  END_DESC

  example [
    '--only "Shape Up" --source "Ryan Singer, Jason Fried (2019) _Shape Up_"'
  ]

  option :only, desc: "Restrict output to highlights from books that include this string"
  option :source, desc: "Replace the book name with this in the output"
  argument :path,
    default: DEFAULT_CLIPPINGS_PATH,
    desc: "The path to 'My Clippings.txt' take from a Kindle. Default: #{DEFAULT_CLIPPINGS_PATH}"

  HIGHLIGHT_PREFIX = "- Your Highlight"

  def call(path:, only: nil, source: nil)
    clippings = clippings_from(path)
      .select { clipping_has_valid_book?(_1, only) }
      .map { rename_book(_1, source) }
    write_clippings_as_csv(clippings)
  end

  private

    def clippings_from(path)
      File.read(path, encoding: 'bom|utf-8')
        .gsub("\uFEFF", '') # wtf is a BOM doing in the middle of the file?
        .gsub(/\r\n?/, "\n")
        .split(/^=+$/)
        .map(&:strip)
        .select { _1.include?(HIGHLIGHT_PREFIX) }
        .map { parse_clipping(_1) }
    end

    def parse_clipping(clipping)
      book, meta_line, *quote = clipping.lines
      meta = parse_meta_line(meta_line)

      {
        book: book.strip,
        quote: quote.join.strip,
        **meta,
      }
    end

    def parse_meta_line(meta_line)
      parts = meta_line.delete_prefix(HIGHLIGHT_PREFIX).split('|').map(&:strip)
      parts.map do |p|
        case p
        when /\Aon page (\d+)(-\d+)?\z/
          { page: Integer($1) }
        when /\A(at )?location (\d+)-(\d+)\z/
          { loc_start: Integer($2), loc_end: Integer($3) }
        when /\AAdded on (.*)\z/
          { added_on: Time.parse($1) }
        else
          raise "Unhandled meta part: #{p.inspect}"
        end
      end.reduce({}, :merge)
    end

    def clipping_has_valid_book?(clipping, only)
      if only
        clipping.fetch(:book).include?(only)
      else
        true
      end
    end

    def rename_book(clipping, new_name)
      if new_name
        clipping.merge(book: new_name)
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
      location = c[:page] ? "page #{c[:page]}" : "location #{c.fetch(:loc_start)}"
      block_quote = word_wrap(c.fetch(:quote), max_len: 80, prefix: '> ')
      citation = [
        "#{c.fetch(:book)} #{location}",
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
end


if ARGV.empty? && !File.exist?(DEFAULT_CLIPPINGS_PATH)
  ARGV << '--help'
end
Dry::CLI.new(Command).call
