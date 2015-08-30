-- Global variables for luakit
globals = {
    homepage            = "luakit://bookmarks/",
    scroll_step         = 40,
    zoom_step           = 0.1,
    max_cmd_history     = 100,
    max_srch_history    = 100,
 -- proxy must now be set through proxy command; environment variable is broken
    default_window_size = "600x600",
    max_title_len       = 200,

 -- Disables loading of hostnames from /etc/hosts (for large host files)
 -- load_etc_hosts      = false,
 -- Disables checking if a filepath exists in search_open function
 -- check_filepath      = false,
 -- Specify your preferred terminal emulator
 -- term                = "urxvt",
}

-- Make useragent
local _, arch = luakit.spawn_sync("uname -sm")
-- Only use the luakit version if in date format (reduces identifiability)
local lkv = string.match(luakit.version, "^(%d+%.%d+%.%d+)")
globals.useragent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.215 Safari/535.1"

-- Search common locations for a ca file which is used for ssl connection validation.
local ca_files = {
    -- $XDG_DATA_HOME/luakit/ca-certificates.crt
    luakit.data_dir .. "/ca-certificates.crt",
    "/etc/certs/ca-certificates.crt",
    "/etc/ssl/certs/ca-certificates.crt",
}
-- Use the first ca-file found
for _, ca_file in ipairs(ca_files) do
    if os.exists(ca_file) then
        soup.ssl_ca_file = ca_file
        break
    end
end

-- Change to stop navigation sites with invalid or expired ssl certificates
soup.ssl_strict = false

-- Set cookie acceptance policy
cookie_policy = { always = 0, never = 1, no_third_party = 2 }
soup.accept_policy = cookie_policy.always

-- List of search engines. Each item must contain a single %s which is
-- replaced by URI encoded search terms. All other occurances of the percent
-- character (%) may need to be escaped by placing another % before or after
-- it to avoid collisions with lua's string.format characters.
-- See: http://www.lua.org/manual/5.1/manual.html#pdf-string.format
search_engines = {
    -- default: Google検索
    default_search = "https://www.google.co.jp/search?q=%s",
    -- I'm feeling lucky!
    l = "https://www.google.co.jp/search?q=%s&btnI=I",
    -- "w": Wikipedia
    w = "https:ja.wikipedia.org/wiki/%s",
    -- "n": niconico動画
    n = "http://www.nicovideo.jp/search/%s",
    -- "nd": ニコニコ大百科
    nd = "http://dic.nicovideo.jp/s/al/a/%s",
    -- "p": Google画像検索
    p = "http://www.google.com/search?hl=ja&site=imghp&tbm=isch&source=hp&q=%s&oq=%s",
    -- "m": Google Map
    m = "https://www.google.com/maps/place/%s",
    -- "mfh": Google Map Navigation "from Home to ***"
    -- if you set the searching language 'English',
    -- then replace "自宅" to "Home"
    mfh = "https://www.google.com/maps/dir/自宅/%s",
    -- "mfw": Google Map Navigation "from Work to ***"
    -- if you set the searching language 'English',
    -- then replace "職場" to "Work"
    mfw = "https://www.google.com/maps/dir/職場/%s",
    -- "mfh": Google Map Navigation "from *** to Home"
    -- if you set the searching language 'English',
    -- then replace "自宅" to "Home"
    mth = "https://www.google.com/maps/dir/%s/自宅",
    -- "mfw": Google Map Navigation "from *** to Work"
    -- if you set the searching language 'English',
    -- then replace "職場" to "Work"
    mtw = "https://www.google.com/maps/dir/%s/職場",
    -- "ip": IP address search
    ip = "http://www.ip-adress.com/whois/%s",
    -- 'f': flickr
    f = "https://www.flickr.com/search/?text=%s&safe_search=3",
    -- "y": Youtubeで検索
    y = "http://www.youtube.com/results?search_query=%s&sm=3",
    -- "rt" Yahooリアルタイム検索
    rt = "http://realtime.search.yahoo.co.jp/search?p=%s&ei=UTF-8",
    -- "sc" Google Scholar検索
    sc = "http://scholar.google.co.jp/scholar?as_vis=1&q=%s&hl=ja&as_sdt=1,5",
    -- "q" Qiita 検索
    q = "http://qiita.com/search?q=%s",
    -- "g" Githubを検索
    g = "https://github.com/search?q=%s",
    -- "gu" Githubを検索(ユーザーを検索)
    gu = "https://github.com/search?q=%s&type=Users",
    -- "gs" Gistを検索
    gs = "https://gist.github.com/search?utf8=✓&q=%s",
    -- "t": 翻訳
    t = "http://ejje.weblio.jp/content/%s",
}

-- Set google as fallback search engine
search_engines.default = search_engines.default_search
-- Use this instead to disable auto-searching
--search_engines.default = "%s"

-- Per-domain webview properties
-- See http://webkitgtk.org/reference/webkitgtk/stable/WebKitWebSettings.html
domain_props = {
    ["all"] = {
        default_font_family = "TakaoPGothic",
        sans_serif_font_family = "TakaoPGothic",
        serif_font_family = "TakaoPMincho",
        fantasy_font_family = "TakaoPMincho",
        cursive_font_family = "TakaoPMincho",
        monospace_font_family = "Inconsolata for Powerline",
        default_font_size = 12,
        default_monospace_font_size = 13,
        minimum_font_size = 8,
        enable_smooth_scrolling = true,
        enforce_96_dpi = true,
        user_stylesheet_uri = "file://" .. luakit.data_dir .. "adblock.css",
    },
    --[[
    ["all"] = {
        enable_scripts          = false,
        enable_plugins          = false,
        enable_private_browsing = false,
        user_stylesheet_uri     = "",
    },
    ["youtube.com"] = {
        enable_scripts = true,
        enable_plugins = true,
    },
    ["bbs.archlinux.org"] = {
        user_stylesheet_uri     = "file://" .. luakit.data_dir .. "/styles/dark.css",
        enable_private_browsing = true,
    }, ]]
}

-- vim: et:sw=4:ts=8:sts=4:tw=80
