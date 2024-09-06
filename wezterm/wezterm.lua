local wezterm = require 'wezterm'
local dracula = require 'dracula'

local config = wezterm.config_builder()

-----------
-- config --
-----------

-- maximize window on startup
wezterm.on("gui-startup", function()
  local tab, pane, window = wezterm.mux.spawn_window{}
  window:gui_window():maximize()
end)

-- use power shell
config.default_prog = { 'powershell.exe' }


------------------
-- key bindings --
------------------


--------
-- ui --
--------

-- size

-- font
config.font = wezterm.font "FiraCode Nerd Font Mono"
config.font_size = 12

-- color theme
config.colors = dracula
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false


return config