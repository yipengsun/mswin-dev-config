local wezterm = require 'wezterm'
local dracula = require 'dracula'


------------
-- config --
------------

local config = wezterm.config_builder()


config.scrollback_lines = 3000
config.warn_about_missing_glyphs = false

-- maximize window on startup
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)


-- use power shell 7
config.default_prog = { 'pwsh.exe', '-NoLogo' }


-- wsl domain
config.wsl_domains = {
  {
    name = 'WSL:NixOS',
    distribution = 'NixOS',
    default_prog = {
      '/run/current-system/sw/bin/fish',
      '-c',
      -- to get a working user login session
      'while not test -S /run/dbus/system_bus_socket; sleep 1; end;' ..
      'if test -e /run/user/1000/bus; exec fish; end;' ..
      'sudo systemctl restart user@1000.service;' ..
      'exec fish;',
    },
    default_cwd = '~',
  },
}


------------------
-- key bindings --
------------------

config.disable_default_key_bindings = true

local act = wezterm.action
config.keys = {
  -- non ctrl-alt key bindings
  -- copy/paste from/to clipboard
  {
    key = 'c',
    mods = 'CTRL|SHIFT',
    action = act.CopyTo 'ClipboardAndPrimarySelection'
  },
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = act.PasteFrom 'PrimarySelection'
  },

  -- open search overlay
  {
    key = 'f',
    mods = 'CTRL|SHIFT',
    action = act.Search { CaseSensitiveString = '' },
  },

  -- open a new window in cwd, not working on windows
  { key = 'Enter', mods = 'CTRL|SHIFT', action = act.SpawnWindow },

  -- jump to next tab
  {
    key = 'Tab',
    mods = 'CTRL',
    action = act.ActivateTabRelative(1),
  },
  -- jump to previous tab
  {
    key = 'Tab',
    mods = 'CTRL|SHIFT',
    action = act.ActivateTabRelative(-1),
  },

  -- scroll page
  {
    key = 'PageUp',
    mods = 'SHIFT',
    action = act.ScrollByPage(-1),
  },
  {
    key = 'PageDown',
    mods = 'SHIFT',
    action = act.ScrollByPage(1),
  },


  -- ctrl-alt key bindings
  -- activates the debug overlay
  { key = 'l', mods = 'CTRL|SHIFT|ALT', action = act.ShowDebugOverlay },

  -- reload
  { key = 'r', mods = 'CTRL|SHIFT|ALT', action = act.ReloadConfiguration },

  -- create a new tab in the same domain as the current pane
  {
    key = 'c',
    mods = 'CTRL|ALT',
    action = act.SpawnTab 'CurrentPaneDomain',
  },

  -- split current pane horizontally: p -> p1 | p2
  {
    key = '\\',
    mods = 'CTRL|ALT',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  -- split current pane vertically:
  --   p -> p1
  --        -
  --        p2
  {
    key = "'",
    mods = 'CTRL|ALT',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },

  -- kill current pane
  {
    key = 'k',
    mods = 'CTRL|ALT',
    action = act.CloseCurrentPane { confirm = true },
  },

  -- navigate between panes
  {
    key = 'LeftArrow',
    mods = 'CTRL|ALT',
    action = act.ActivatePaneDirection('Left'),
  },
  {
    key = 'RightArrow',
    mods = 'CTRL|ALT',
    action = act.ActivatePaneDirection('Right'),
  },
  {
    key = 'UpArrow',
    mods = 'CTRL|ALT',
    action = act.ActivatePaneDirection('Up'),
  },
  {
    key = 'DownArrow',
    mods = 'CTRL|ALT',
    action = act.ActivatePaneDirection('Down'),
  },

  -- resize current pane
  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT|ALT',
    action = act.AdjustPaneSize {'Left', 2},
  },
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT|ALT',
    action = act.AdjustPaneSize {'Right', 2},
  },
  {
    key = 'UpArrow',
    mods = 'CTRL|SHIFT|ALT',
    action = act.AdjustPaneSize {'Up', 2},
  },
  {
    key = 'DownArrow',
    mods = 'CTRL|SHIFT|ALT',
    action = act.AdjustPaneSize {'Down', 2},
  },

  -- open a power shell session in a new tab
  {
    key = 'q',
    mods = 'CTRL|ALT',
    action = act.SpawnTab { DomainName = 'local'},
  },
  -- open a wsl session in a new tab
  {
    key = 'w',
    mods = 'CTRL|ALT',
    action = act.SpawnTab { DomainName = 'WSL:NixOS'},
  },
}

-- switch between tabs
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL|ALT',
    action = act.ActivateTab(i - 1),
  })
end


config.mouse_bindings = {
	-- CTRL left-click
  -- open url under the mouse cursor
	{
		event = { Up = { streak = 1, button = 'Left' } },
		mods = 'CTRL',
		action = act.OpenLinkAtMouseCursor,
	},
}


--------
-- ui --
--------

-- font
config.font = wezterm.font 'FiraCode Nerd Font Mono'
config.font_size = 12


-- color theme
config.colors = dracula
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false


return config
