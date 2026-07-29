local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- config.color_scheme = 'Catppuccin Macchiato'
config.color_scheme = "Noctalia"
config.font = wezterm.font 'Maple Mono'
config.window_background_opacity = 0.8
config.hide_tab_bar_if_only_one_tab = true

return config

