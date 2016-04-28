-- Local settings for specific machine

domain_props["all"].default_font_size = 14
domain_props["all"].default_monospace_font_size = 16
domain_props["all"].minimum_font_size = 10
domain_props["all"].enable_smooth_scrolling = true

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
    padding: 2px 2px;
    font-family: monospace, courier, sans-serif;
    font-size: 16px;
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

