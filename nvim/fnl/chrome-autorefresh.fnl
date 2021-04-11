(module chrome-autorefresh
  {require {core aniseed.core
            nvim aniseed.nvim
            str aniseed.string}})

(defonce- state
  {:tab-to-refresh nil})

(defn- run-applescript [source]
  (str.trim (nvim.fn.system "osascript -" source)))

(defn- refresh-tab-applescript []
  "Applescript source code for refreshing tab-to-refresh in Chrome"
  (str.join "\n" [
    "tell application \"Chrome\""
    "  repeat with the_window in every window"
    "    set the_tab_index to 0"
    "    repeat with the_tab in every tab of the_window"
    "      set the_tab_index to the_tab_index + 1"
    (.. "      if id of the_tab is equal to " state.tab-to-refresh " then")
    "        tell the_tab to reload"
    "        set active tab index of the_window to the_tab_index"
    "        set index of the_window to 1"
    "      end if"
    "    end repeat"
    "  end repeat"
    "end tell"]))

(def- current-chrome-tab-applescript
  (str.join "\n" [
  "tell application \"Google Chrome\""
  "  get id of active tab of first window whose visible is true"
  "end tell"]))

(defn- current-chrome-tab []
  "Gets the id of the current tab of the frontmost Chrome window"
  (run-applescript current-chrome-tab-applescript))

(defn- create-augroup []
  (nvim.ex.augroup *module-name*)
  (nvim.ex.autocmd_)
  (nvim.ex.au :BufWritePost :* "lua require('chrome-autorefresh')['on-buffer-write']()")
  (nvim.ex.augroup :END))

(defn- remove-augroup []
  (nvim.ex.augroup *module-name*)
  (nvim.ex.autocmd_)
  (nvim.ex.augroup :END))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Public

(defn enable []
  (set state.tab-to-refresh (current-chrome-tab))
  (create-augroup))

(defn disable []
  (set state.tab-to-refresh nil)
  (remove-augroup))

(defn on-buffer-write []
  (run-applescript (refresh-tab-applescript)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Commands

(nvim.ex.command_ "ChromeAutorefreshEnable"
  "lua require('chrome-autorefresh')['enable']()")

(nvim.ex.command_ "ChromeAutorefreshDisable"
  "lua require('chrome-autorefresh')['disable']()")
