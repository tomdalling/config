local _0_0 = nil
do
  local name_0_ = "chrome-autorefresh"
  local module_0_ = nil
  do
    local x_0_ = package.loaded[name_0_]
    if ("table" == type(x_0_)) then
      module_0_ = x_0_
    else
      module_0_ = {}
    end
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = ((module_0_)["aniseed/locals"] or {})
  module_0_["aniseed/local-fns"] = ((module_0_)["aniseed/local-fns"] or {})
  package.loaded[name_0_] = module_0_
  _0_0 = module_0_
end
local function _1_(...)
  local ok_3f_0_, val_0_ = nil, nil
  local function _1_()
    return {require("aniseed.core"), require("aniseed.nvim"), require("aniseed.string")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {require = {core = "aniseed.core", nvim = "aniseed.nvim", str = "aniseed.string"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local core = _local_0_[1]
local nvim = _local_0_[2]
local str = _local_0_[3]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "chrome-autorefresh"
do local _ = ({nil, _0_0, {{}, nil, nil, nil}})[2] end
local state = nil
do
  local v_0_ = (((_0_0)["aniseed/locals"]).state or {["tab-to-refresh"] = nil})
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["state"] = v_0_
  state = v_0_
end
local run_applescript = nil
do
  local v_0_ = nil
  local function run_applescript0(source)
    return str.trim(nvim.fn.system("osascript -", source))
  end
  v_0_ = run_applescript0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["run-applescript"] = v_0_
  run_applescript = v_0_
end
local refresh_tab_applescript = nil
do
  local v_0_ = nil
  local function refresh_tab_applescript0()
    return str.join("\n", {"tell application \"Chrome\"", "  repeat with the_window in every window", "    set the_tab_index to 0", "    repeat with the_tab in every tab of the_window", "      set the_tab_index to the_tab_index + 1", ("      if id of the_tab is equal to " .. state["tab-to-refresh"] .. " then"), "        tell the_tab to reload", "        set active tab index of the_window to the_tab_index", "        set index of the_window to 1", "      end if", "    end repeat", "  end repeat", "end tell"})
  end
  v_0_ = refresh_tab_applescript0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["refresh-tab-applescript"] = v_0_
  refresh_tab_applescript = v_0_
end
local current_chrome_tab_applescript = nil
do
  local v_0_ = str.join("\n", {"tell application \"Google Chrome\"", "  get id of active tab of first window whose visible is true", "end tell"})
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["current-chrome-tab-applescript"] = v_0_
  current_chrome_tab_applescript = v_0_
end
local current_chrome_tab = nil
do
  local v_0_ = nil
  local function current_chrome_tab0()
    return run_applescript(current_chrome_tab_applescript)
  end
  v_0_ = current_chrome_tab0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["current-chrome-tab"] = v_0_
  current_chrome_tab = v_0_
end
local create_augroup = nil
do
  local v_0_ = nil
  local function create_augroup0()
    nvim.ex.augroup(_2amodule_name_2a)
    nvim.ex.autocmd_()
    nvim.ex.au("BufWritePost", "*", "lua require('chrome-autorefresh')['on-buffer-write']()")
    return nvim.ex.augroup("END")
  end
  v_0_ = create_augroup0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["create-augroup"] = v_0_
  create_augroup = v_0_
end
local remove_augroup = nil
do
  local v_0_ = nil
  local function remove_augroup0()
    nvim.ex.augroup(_2amodule_name_2a)
    nvim.ex.autocmd_()
    return nvim.ex.augroup("END")
  end
  v_0_ = remove_augroup0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["remove-augroup"] = v_0_
  remove_augroup = v_0_
end
local enable = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function enable0()
      state["tab-to-refresh"] = current_chrome_tab()
      return create_augroup()
    end
    v_0_0 = enable0
    _0_0["enable"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["enable"] = v_0_
  enable = v_0_
end
local disable = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function disable0()
      state["tab-to-refresh"] = nil
      return remove_augroup()
    end
    v_0_0 = disable0
    _0_0["disable"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["disable"] = v_0_
  disable = v_0_
end
local on_buffer_write = nil
do
  local v_0_ = nil
  do
    local v_0_0 = nil
    local function on_buffer_write0()
      return run_applescript(refresh_tab_applescript())
    end
    v_0_0 = on_buffer_write0
    _0_0["on-buffer-write"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["on-buffer-write"] = v_0_
  on_buffer_write = v_0_
end
nvim.ex.command_("ChromeAutorefreshEnable", "lua require('chrome-autorefresh')['enable']()")
return nvim.ex.command_("ChromeAutorefreshDisable", "lua require('chrome-autorefresh')['disable']()")