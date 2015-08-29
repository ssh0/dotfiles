--------------------------
-- Default luakit theme --
--------------------------

local theme = {}

-- Default settings
theme.font = "Inconsolata normal 9"
theme.fg   = "#fff"
theme.bg   = "#1c1c1c"

-- Genaral colours
theme.success_fg = "#a5d6a7"
theme.loaded_fg  = "#33AADD"
theme.error_fg = "#FFF"
theme.error_bg = "#ef9a9a"

-- Warning colours
theme.warning_fg = "#ef9a9a"
theme.warning_bg = "#FFF"

-- Notification colours
theme.notif_fg = "#444"
theme.notif_bg = "#FFF"

-- Menu colours
theme.menu_fg                   = "#1c1c1c"
theme.menu_bg                   = "#fff"
theme.menu_selected_fg          = "#1c1c1c"
theme.menu_selected_bg          = "#ece391"
theme.menu_title_bg             = "#fff"
theme.menu_primary_title_fg     = "#ef9a9a"
theme.menu_secondary_title_fg   = "#666"

-- Proxy manager
theme.proxy_active_menu_fg      = '#1c1c1c'
theme.proxy_active_menu_bg      = '#FFF'
theme.proxy_inactive_menu_fg    = '#888'
theme.proxy_inactive_menu_bg    = '#FFF'

-- Statusbar specific
theme.sbar_fg         = "#fff"
theme.sbar_bg         = "#1c1c1c"

-- Downloadbar specific
theme.dbar_fg         = "#fff"
theme.dbar_bg         = "#1c1c1c"
theme.dbar_error_fg   = "#ef9a9a"

-- Input bar specific
theme.ibar_fg           = "#1c1c1c"
theme.ibar_bg           = "#fff"

-- Tab label
theme.tab_fg            = "#888"
theme.tab_bg            = "#1c1c1c"
theme.tab_ntheme        = "#ddd"
theme.selected_fg       = "#fff"
theme.selected_bg       = "#363636"
theme.selected_ntheme   = "#ddd"
theme.loading_fg        = "#fff"
theme.loading_bg        = "#363636"

-- Trusted/untrusted ssl colours
theme.trust_fg          = "#a5d6a7"
theme.notrust_fg        = "#ef9a9a"

return theme
-- vim: et:sw=4:ts=8:sts=4:tw=80
