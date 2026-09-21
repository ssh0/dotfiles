local wezterm = require 'wezterm';

return {
  -- font = wezterm.font_with_fallback {'Cica' },
  -- font = wezterm.font_with_fallback { 'Fira Code'},
  font = wezterm.font_with_fallback {'Migu 1M' },
  use_ime = true,
  font_size = 15,
  line_height = 1.3,
  -- https://wezfurlong.org/wezterm/colorschemes/index.html
  color_scheme = 'Flexoki Light',
  enable_tab_bar = false,
  enable_kitty_keyboard = false,
  adjust_window_size_when_changing_font_size = false,
  window_padding = {
      left = 0,
      right = 0,
      top = 0,
      bottom = 0
  },
  window_decorations = 'RESIZE',
  -- window_decorations = 'MACOS_FORCE_SQUARE_CORNERS | RESIZE',
  treat_east_asian_ambiguous_width_as_wide = true,
  default_cursor_style = 'SteadyBlock',
  keys = {
    { key = 'Enter', mods = 'ALT', action = wezterm.action.DisableDefaultAssignment },
  },
}
