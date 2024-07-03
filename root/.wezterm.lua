local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
local custom_color = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom_color.background = "#100f0f"

config.color_schemes = {
	["OLEDppuccin"] = custom_color,
}
-- Color scheme setup
config.color_scheme = "OLEDppuccin"

-- Cursor settings
config.cursor_blink_rate = 0
config.cursor_thickness = "1px"

-- Enable scroll bar
config.enable_scroll_bar = false
-- How many lines of scrollback you want to retain per tab
config.scrollback_lines = 1000000

-- Enable Wayland support
config.enable_wayland = true

-- Font settings
config.font = wezterm.font("BerkeleyMonoVariable2 Nerd Font Mono")
config.font_size = 13.5

-- Tab bar settings
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false

-- Window settings
config.window_background_opacity = 0.98
config.window_decorations = "TITLE | RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Default shell and terminal type
config.default_prog = { "/bin/zsh", "-l", "-c", "tmux" }
config.term = "xterm-256color"
config.enable_tab_bar = true
-- tmux
local function tmux_binding(key, tmux_key, mods)
	local m = mods or "CMD"
	return {
		key = key,
		mods = m,
		action = wezterm.action.Multiple({
			wezterm.action.SendKey({ key = "a", mods = "CTRL" }), -- Send Ctrl+a
			wezterm.action.SendKey({ key = tmux_key }),
		}),
	}
end
-- Key bindings
config.keys = {
	-- Turn off the default CMD-m Hide action, allowing CMD-m to
	-- be potentially recognized and handled by the tab
	{ key = "w", mods = "CMD", action = wezterm.action.DisableDefaultAssignment },
	{ key = "t", mods = "CMD", action = wezterm.action.DisableDefaultAssignment },
	{ key = "d", mods = "CMD", action = wezterm.action.DisableDefaultAssignment },
	{ key = "h", mods = "CMD", action = wezterm.action.DisableDefaultAssignment },
	tmux_binding("t", "c"), -- New tab
	tmux_binding("w", "w"), -- Close pane
	tmux_binding("h", "LeftArrow"), -- New tab
	tmux_binding("j", "DownArrow"), -- Move to down pane
	tmux_binding("k", "UpArrow"), -- Move to up pane
	tmux_binding("l", "LeftArrow"), -- Move to left pane
	tmux_binding("d", "v"), -- vertical split
	tmux_binding("d", "s", "CMD|SHIFT"), -- horizontal split
	tmux_binding("h", "H", "CMD|SHIFT"),
	tmux_binding("j", "J", "CMD|SHIFT"),
	tmux_binding("k", "K", "CMD|SHIFT"),
	tmux_binding("l", "L", "CMD|SHIFT"),
}

-- cmd 1-9
for i = 1, 9 do
	table.insert(config.keys, tmux_binding(tostring(i), tostring(i)))
end

config.front_end = "OpenGL"

-- Return the configuration to WezTerm
return config
