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

-- use power shell 7
config.default_prog = { 'pwsh.exe' }


------------------
-- key bindings --
------------------

config.disable_default_key_bindings = true

local act = wezterm.action
config.keys = {
  -- CTRL-SHIFT c
  -- copy to clipboard
  {
    key = 'c',
    mods = 'CTRL|SHIFT',
    action = act.CopyTo 'ClipboardAndPrimarySelection'
  },

  -- CTRL-SHIFT v
  -- paste from clibboard
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = act.PasteFrom 'PrimarySelection'
  },

  -- CTRL-SHIFT l
  -- activates the debug overlay
  { key = 'l', mods = 'CTRL|SHIFT', action = act.ShowDebugOverlay },

  -- CTRL-SHIFT r
  -- reload
  { key = 'r', mods = 'CTRL|SHIFT', action = act.ReloadConfiguration },

  -- CTRL-ALT c
  -- create a new tab in the same domain as the current pane
  {
    key = 'c',
    mods = 'CTRL|ALT',
    action = act.SpawnTab 'CurrentPaneDomain',
  },

  -- CTRL-ALT \
  -- split current pane horizontally: p -> p1 | p2
  {
    key = '\\',
    mods = 'CTRL|ALT',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },

  -- CTRL-ALT '
  -- split current pane vertically:
  --   p -> p1
  --        -
  --        p2
  {
    key = "'",
    mods = 'CTRL|ALT',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },

  -- CTRL-ALT k
  {
    key = 'k',
    mods = 'CTRL|ALT',
    action = act.CloseCurrentPane { confirm = true },
  },
}


config.mouse_bindings = {
	-- CTRL left-click
  -- open url under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
}


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