-----------------------------------------------------------------------
-- luakit configuration file, more information at http://luakit.org/ --
-----------------------------------------------------------------------

require "lfs"

if unique then
    unique.new("org.luakit")
    -- Check for a running luakit instance
    if unique.is_running() then
        if uris[1] then
            for _, uri in ipairs(uris) do
                if lfs.attributes(uri) then uri = os.abspath(uri) end
                unique.send_message("tabopen " .. uri)
            end
        else
            unique.send_message("winopen")
        end
        luakit.quit()
    end
end

-- Load library of useful functions for luakit
require "lousy"

-- Small util functions to print output (info prints only when luakit.verbose is true)
function warn(...) io.stderr:write(string.format(...) .. "\n") end
function info(...) if luakit.verbose then io.stdout:write(string.format(...) .. "\n") end end

-- Load users global config
-- ("$XDG_CONFIG_HOME/luakit/globals.lua" or "/etc/xdg/luakit/globals.lua")
require "globals"

-- Load users theme
-- ("$XDG_CONFIG_HOME/luakit/theme.lua" or "/etc/xdg/luakit/theme.lua")
lousy.theme.init(lousy.util.find_config("theme.lua"))
theme = assert(lousy.theme.get(), "failed to load theme")

-- Load users window class
-- ("$XDG_CONFIG_HOME/luakit/window.lua" or "/etc/xdg/luakit/window.lua")
require "window"

-- Show progressbar
window.methods.update_progress = function (w)
    local p = w.view.progress
    if not p then p = w.view:get_prop("progress") end
    local loaded = w.sbar.r.loaded
    if not w.view:loading() or p == 1 then
        loaded:hide()
        if w.sbar.hidden then w.sbar.ebox:hide() end
    else
        w.sbar.ebox:show()
        loaded:show()
        local pbar = { }
        local strlen = 33
        local pstrlen = math.floor((p*strlen))
        for i=1,pstrlen do pbar[i] = "█" end
        for i=pstrlen+1,strlen do pbar[i] = "." end
        local text = string.format("%s %d%%", table.concat(pbar, ""), p * 100)
        if loaded.text ~= text then loaded.text = text end
    end
end

-- Load users webview class
-- ("$XDG_CONFIG_HOME/luakit/webview.lua" or "/etc/xdg/luakit/webview.lua")
require "webview"

-- Load users mode configuration
-- ("$XDG_CONFIG_HOME/luakit/modes.lua" or "/etc/xdg/luakit/modes.lua")
require "modes"

-- Load users keybindings
-- ("$XDG_CONFIG_HOME/luakit/binds.lua" or "/etc/xdg/luakit/binds.lua")
require "binds"

add_binds("normal", {
    -- Toggle status bar
    lousy.bind.key({"Shift"}, "F11", "Toggle show the status bar.",
        function (w, a, o)
            if w.sbar.hidden then
                w.sbar.ebox:show()
                w.sbar.hidden = false
            else
                w.sbar.ebox:hide()
                w.sbar.hidden = true
            end
        end),

    -- Yanking
    lousy.bind.buf("^cu$", "Yank current URI to clipboard.",
        function (w)
            local uri = string.gsub(w.view.uri or "", " ", "%%20")
            luakit.selection.clipboard = uri
            w:notify("Yanked uri (to clipboard): " .. uri)
        end),

    lousy.bind.buf("^ct$", "Yank current title to clipboard.",
        function (w)
            local title = w.view.title or ""
            luakit.selection.primary = title
            luakit.selection.clipboard = luakit.selection.primary
            w:notify("Yanked title (to clipboard): " .. title)
        end),

    lousy.bind.key({"Control"}, "c", "Copy (as-in) control-c control-v",
        function (w)
            luakit.selection.clipboard = luakit.selection.primary
        end),

    lousy.bind.key({"Mod1"}, "Left", "Go to previous tab.",
        function (w) w:prev_tab() end),

    lousy.bind.key({"Mod1"}, "Right", "Go to next tab.",
        function (w) w:next_tab() end),

    lousy.bind.key({"Mod1"}, "h", "Go to previous tab.",
        function (w) w:prev_tab() end),

    lousy.bind.key({"Mod1"}, "l", "Go to next tab.",
        function (w) w:next_tab() end),

    lousy.bind.key({"Mod1"}, "H", "Reorder tab left `[count=1]` positions.",
        function (w, m)
            w.tabs:reorder(w.view, w.tabs:current() - m.count)
        end, {count=1}),

    lousy.bind.key({"Mod1"}, "L", "Reorder tab right `[count=1]` positions.",
        function (w, m)
            w.tabs:reorder(w.view,
                (w.tabs:current() + m.count) % w.tabs:count())
        end, {count=1})
})

add_binds("insert", {
    lousy.bind.key({"Control"},  "e",
        "Edit text fields in an external editor.",
        function (w)
            local s = w.view:eval_js("document.activeElement.value")

            local n = "/tmp/" .. os.time()
            local f = io.open(n, "w")
            f:write(s)
            f:flush()
            f:close()

            luakit.spawn_sync("urxvt -g 90x20 -title \"urxvt_float\" -name \"urxvt_float\" -e nvim \"" .. n .. "\" -c \"set completefunc=googlesuggest#Complete\"")

            f = io.open(n, "r")
            s = f:read("*all")
            f:close()
            -- Strip the string
            s = s:gsub("^%s*(.-)%s*$", "%1")
            -- Escape it but remove the quotes
            s = string.format("%q", s):sub(2, -2)
            -- lua escaped newlines (slash+newline) into js newlines (slash+n)
            s = s:gsub("\\\n", "\\n")
            w.view:eval_js("document.activeElement.value = '" .. s .. "'")
        end)
})

add_cmds({
    lousy.bind.cmd("pr[ivate]", "Toggle private browsing tab.",
        function (w)
            w.view.enable_private_browsing = not w.view.enable_private_browsing
            w:update_tablist()
        end)
})

ex_follow_bindings = {
    -- Yank element uri to open in an external application
    lousy.bind.key({}, "d", [[Hint all links (as defined by the `follow.selectors.uri`
        selector) and excute external program to the matched elements URI.]],
        function (w)
            w:set_mode("follow", {
                prompt = "external", selector = "uri", evaluator = "uri",
                func = function (uri)
                    assert(type(uri) == "string")
                    uri = string.gsub(uri, " ", "%%20")
                    luakit.selection.primary = uri
                    if string.match(uri, "youtube") then
                        luakit.spawn(string.format("youtube-dl %s -o - | mpv -", uri))
                        w:notify("trying to play file on mpv " .. uri)
                    elseif string.match(uri, "vimeo") then
                        luakit.spawn(string.format("youtube-dl %s -o - | mpv -", uri))
                        w:notify("trying to play file on mpv " .. uri)
                    elseif string.match(uri, "vine") then
                        luakit.spawn(string.format("youtube-dl %s -o - | mpv -", uri))
                        w:notify("trying to play file on mpv " .. uri)
                    elseif string.match(uri, "nicovideo") then
                        luakit.spawn(string.format("youtube-dl %s -o - | mpv -", uri))
                        w:notify("trying to play file on mpv " .. uri)
                    elseif string.match(uri, "file:///") then
                        luakit.spawn(string.format("xdg-open %s", uri))
                        w:notify("trying to open with xdg-open " .. uri)
                    elseif string.match(uri, "jpg" or "JPG" or "png" or "PNG" or "gif" or "GIF") then
                        luakit.spawn(string.format("feh --scale-down %s", uri))
                        w:notify("file contains image")
                    else
                        w:notify("unrecognized format")
                    end
                end
            })
        end),

    -- Yank element uri or description into primary selection
    lousy.bind.key({}, "y", [[Hint all links (as defined by the `follow.selectors.uri`
        selector) and set the primary selection to the matched elements URI.]],
        function (w)
            w:set_mode("follow", {
                prompt = "yank", selector = "uri", evaluator = "uri",
                func = function (uri)
                    assert(type(uri) == "string")
                    uri = string.gsub(uri, " ", "%%20")
                    -- capi.luakit.selection.primary = uri
                    luakit.selection.primary = uri
                    luakit.selection.clipboard = luakit.selection.primary
                    w:notify("Yanked uri: " .. uri, false)
                end
            })
        end),

    -- Yank element description
    lousy.bind.key({}, "Y", [[Hint all links (as defined by the `follow.selectors.uri`
        selector) and set the primary selection to the matched elements URI.]],
        function (w)
            w:set_mode("follow", {
                prompt = "yank desc", selector = "desc", evaluator = "desc",
                func = function (desc)
                    assert(type(desc) == "string")
                    -- capi.luakit.selection.primary = desc
                    luakit.selection.primary = desc
                    luakit.selection.clipboard = luakit.selection.primary
                    w:notify("Yanked desc: " .. desc)
                end
            })
        end)
}

add_binds({"ex-follow"}, ex_follow_bindings)

----------------------------------
-- Optional user script loading --
----------------------------------

-- adblock
require "plugins.adblock"
require "plugins.adblock_chrome"

-- private browsing tabs
require "plugins.private_browsing_tabs"

require "webinspector"

-- Add sqlite3 cookiejar
require "cookies"

-- Cookie blocking by domain (extends cookies module)
-- Add domains to the whitelist at "$XDG_CONFIG_HOME/luakit/cookie.whitelist"
-- and blacklist at "$XDG_CONFIG_HOME/luakit/cookie.blacklist".
-- Each domain must be on it's own line and you may use "*" as a
-- wildcard character (I.e. "*google.com")
--require "cookie_blocking"

-- Block all cookies by default (unless whitelisted)
--cookies.default_allow = false

-- Add uzbl-like form filling
require "formfiller"

-- Add proxy support & manager
require "proxy"

-- Add quickmarks support & manager
require "quickmarks"

-- Add session saving/loading support
require "session"

-- Add command to list closed tabs & bind to open closed tabs
require "undoclose"

add_binds("normal", {
    lousy.bind.key({}, "U", "View closed tabs in a list.",
        function (w) w:set_mode("undolist")  end),
})

-- Add command to list tab history items
require "tabhistory"

-- Add greasemonkey-like javascript userscript support
require "userscripts"

-- Add bookmarks support
require "bookmarks"
require "bookmarks_chrome"

-- Add download support
require "downloads"
require "downloads_chrome"

-- Example using xdg-open for opening downloads / showing download folders
downloads.add_signal("open-file", function (file, mime)
    luakit.spawn(string.format("xdg-open %q", file))
    return true
end)

-- Add vimperator-like link hinting & following
require "follow"

-- Use a custom charater set for hint labels
local s = follow.label_styles
follow.label_maker = s.charset("fjkasdhguonmerwc")

follow.stylesheet = [===[
#luakit_follow_overlay {
    position: absolute;
    left: 0;
    top: 0;
}

#luakit_follow_overlay .hint_overlay {
    display: block;
    position: absolute;
    background-color: #ffff99;
    opacity: 0.3;
    z-index: 999999999;
}

#luakit_follow_overlay .hint_label {
    display: block;
    position: absolute;
    background-color: #1c1c1c;
    color: #fefefe;
    padding: 2px 5px;
    font-family: monospace, courier, sans-serif;
    font-size: 12px;
    font-weight: bold;
    z-index: 99999999;
}

#luakit_follow_overlay .hint_overlay_body {
    background-color: #e4efff;
}

#luakit_follow_overlay .hint_selected {
    background-color: #00ff00 !important;
}
]===]

-- Match only hint labels
--follow.pattern_maker = follow.pattern_styles.match_label

-- Add command history
require "cmdhist"

-- Add search mode & binds
require "search"

-- Add ordering of new tabs
require "taborder"

-- Save web history
require "history"
require "history_chrome"

require "introspector"

-- Add command completion
require "completion"
-- Order of completion items
completion.order = {
    completion.funcs.command,
    completion.funcs.bookmarks,
    completion.funcs.history,
}

-- NoScript plugin, toggle scripts and or plugins on a per-domain basis.
-- `,ts` to toggle scripts, `,tp` to toggle plugins, `,tr` to reset.
-- Remove all "enable_scripts" & "enable_plugins" lines from your
-- domain_props table (in config/globals.lua) as this module will conflict.
--require "noscript"

require "follow_selected"
require "go_input"
require "go_next_prev"
require "go_up"

-----------------------------
-- End user script loading --
-----------------------------

-- Restore last saved session
local w = (session and session.restore())
if w then
    for i, uri in ipairs(uris) do
        w:new_tab(uri, i == 1)
    end
else
    -- Or open new window
    window.new(uris)
end

-------------------------------------------
-- Open URIs from other luakit instances --
-------------------------------------------

if unique then
    unique.add_signal("message", function (msg, screen)
        local cmd, arg = string.match(msg, "^(%S+)%s*(.*)")
        local w = lousy.util.table.values(window.bywidget)[1]
        if cmd == "tabopen" then
            w:new_tab(arg)
        elseif cmd == "winopen" then
            w = window.new((arg ~= "") and { arg } or {})
        end
        w.win.screen = screen
        w.win.urgency_hint = true
    end)
end

----------------------------------------
-- Local setting for specific machine --
----------------------------------------

require "user_local"

-- vim: et:sw=4:ts=8:sts=4:tw=80
