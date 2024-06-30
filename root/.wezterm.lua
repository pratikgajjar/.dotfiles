local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
local custom_color = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom_color.background = "#100f0f"
custom_color.tab_bar.background = "#040404"
custom_color.tab_bar.inactive_tab.bg_color = "#0f0f0f"
custom_color.tab_bar.new_tab.bg_color = "#080808"

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

-- Enable Wayland support
config.enable_wayland = true

-- Font settings
config.font = wezterm.font("BerkeleyMonoVariable2 Nerd Font Mono")
config.font_size = 13.5

-- Tab bar settings
config.hide_tab_bar_if_only_one_tab = true
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
config.enable_tab_bar = false

-- Key bindings

-- Return the configuration to WezTerm
return config
