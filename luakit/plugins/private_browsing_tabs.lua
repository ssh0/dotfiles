local string = string
local window = window
local webview = webview
local widget = widget
local theme = theme
local luakit = luakit
local lousy = require("lousy")
local util = lousy.util

local print = print
local ipairs = ipairs
local type = type

module("plugins.private_browsing_tabs")

-- Private tab label
theme.private_tab_fg            = "#CC76BB"
theme.private_tab_bg            = "#492F44" 
theme.private_tab_ntheme        = "#DDDDDD"
theme.private_selected_fg       = "#ffffff"
theme.private_selected_bg       = "#793D6D"
theme.private_selected_ntheme   = "#DDDDDD"
theme.private_loading_fg        = "#33AADD"
theme.private_loading_bg        = "#330022"

-- Store the old update_tablist function
_update_tablist = window.methods.update_tablist

-- Override the update_tablist with a new function
window.methods.update_tablist = function(w)
    local current = w.tabs:current()

    local tab_fg, tab_bg, nfg, selected_nfg, loading_fg, selected_tab_fg, selected_tab_bg
    local notrust_fg, trust_fg = theme.tab_notrust_fg, theme.tab_trust_fg

    local escape = lousy.util.escape
    local tabs, tfmt = {}, ' <span foreground="%s">%s</span> %s'

    for i, view in ipairs(w.tabs.children) do
        if view.enable_private_browsing then
            tab_fg = theme.private_tab_fg
            tab_bg = theme.private_tab_bg

            nfg = theme.private_tab_ntheme
            selected_nfg = theme.private_selected_ntheme

            loading_fg = theme.private_loading_fg

            selected_tab_fg = theme.private_selected_fg
            selected_tab_bg = theme.private_selected_bg
        else
            tab_fg = theme.tab_fg
            tab_bg = theme.tab_bg

            nfg = theme.tab_ntheme
            selected_nfg = theme.selected_ntheme

            loading_fg = theme.tab_loading_fg

            selected_tab_fg = theme.tab_selected_fg
            selected_tab_bg = theme.tab_selected_bg
        end

        -- Get tab number theme
        local ntheme = nfg
        if view:loading() then -- Show loading on all tabs
            ntheme = loading_fg
        elseif current == i then -- Show ssl trusted/untrusted on current tab
            local trusted = view:ssl_trusted()
            ntheme = selected_nfg
            if trusted == false or (trusted ~= nil and not w.checking_ssl) then
                ntheme = notrust_fg
            elseif trusted then
                ntheme = trust_fg
            end
        end

        local title = (view.enable_private_browsing and "(Private)") or view.title or view.uri or  "(Untitled)"

        tabs[i] = {
            title = string.format(tfmt, ntheme or tab_fg, i, escape(title)),

            fg = (current == i and selected_tab_fg) or tab_fg,
            bg = (current == i and selected_tab_bg) or tab_bg,
        }
    end

    if #tabs < 2 then tabs, current = {}, 0 end
    w.tablist:update(tabs, current)
end

--Store the old new_tab method from window
_new_tab = window.methods.new_tab

--Override the new_tab method with a new one
window.methods.new_tab = function (w, arg, switch, order)
    local view
    -- Use blank tab first
    if w.has_blank and w.tabs:count() == 1 and w.tabs[1].uri == "about:blank" then
        view = w.tabs[1]
    end
    w.has_blank = nil
    -- Make new webview widget
    if not view then
        view = webview.new(w)

        if w.view and w.view.enable_private_browsing then
            view.enable_private_browsing = true
        end

        -- Get tab order function
        if not order and taborder then
            order = (switch == false and taborder.default_bg)
            or taborder.default
        end
        pos = w.tabs:insert((order and order(w, view)) or -1, view)
        if switch ~= false then w.tabs:switch(pos) end
    end
    -- Load uri or webview history table
    if type(arg) == "string" then view.uri = arg
    elseif type(arg) == "table" then view.history = arg end
    -- Update statusbar widgets
    w:update_tab_count()
    w:update_tablist()
    return view
end

define_colors = function(view)

end
