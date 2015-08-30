--------------------------
-- Default luakit theme --
--------------------------

local theme = {}

-- Default settings
theme.font = "TakaoPGothic normal 9"
theme.fg   = "#ffffff"
theme.bg   = "#1c1c1c"

-- Genaral colours
theme.success_fg = "#a5d6a7"
theme.loaded_fg  = "#33aadd"
theme.error_fg = "#1c1c1c"
theme.error_bg = "#ef9a9a"

-- Warning colours
theme.warning_fg = "#1c1c1c"
theme.warning_bg = "#ef9a9a"

-- Notification colours
theme.notif_fg = "#ffffff"
theme.notif_bg = "#353535"

-- Menu colours
theme.menu_fg                   = "#c6c6c6"
theme.menu_bg                   = "#1c1c1c"
theme.menu_selected_fg          = "#ffffff"
theme.menu_selected_bg          = "#404040"
theme.menu_title_bg             = "#b9e18b"
theme.menu_primary_title_fg     = "#1c1c1c"
theme.menu_secondary_title_fg   = "#1c1c1c"

-- Proxy manager
theme.proxy_active_menu_fg      = '#c6c6c6'
theme.proxy_active_menu_bg      = '#1c1c1c'
theme.proxy_inactive_menu_fg    = '#aaaaaa'
theme.proxy_inactive_menu_bg    = '#1c1c1c'

-- Statusbar specific
theme.sbar_fg         = "#aaaaaa"
theme.sbar_bg         = "#1c1c1c"

-- Downloadbar specific
theme.dbar_fg         = "#aaaaaa"
theme.dbar_bg         = "#1c1c1c"
theme.dbar_error_fg   = "#ef9a9a"

-- Input bar specific
theme.ibar_fg           = "#c6c6c6"
theme.ibar_bg           = "#1c1c1c"

-- Tab label
theme.tab_fg            = "#9e9e9e"
theme.tab_bg            = "#1c1c1c"
theme.tab_ntheme        = "#bdbdbd"
theme.selected_fg       = "#ffffff"
theme.selected_bg       = "#363636"
theme.selected_ntheme   = "#bdbdbd"
theme.loading_fg        = "#ffffff"
theme.loading_bg        = "#363636"

-- Trusted/untrusted ssl colours
theme.trust_fg          = "#a5d6a7"
theme.notrust_fg        = "#ef9a9a"

return theme
-- vim: et:sw=4:ts=8:sts=4:tw=80
