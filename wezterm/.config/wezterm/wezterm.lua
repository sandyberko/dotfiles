local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Macchiato'
config.font = wezterm.font 'Maple Mono'
config.window_background_opacity = 0.8
config.use_fancy_tab_bar = false

return config

