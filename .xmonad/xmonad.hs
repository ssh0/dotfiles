-------------------------------------------------------------------------------
--                  __  ____  __                       _                     --
--                  \ \/ /  \/  | ___  _ __   __ _  __| |                    --
--                   \  /| |\/| |/ _ \| '_ \ / _` |/ _` |                    --
--                   /  \| |  | | (_) | | | | (_| | (_| |                    --
--                  /_/\_\_|  |_|\___/|_| |_|\__,_|\__,_|                    --
--                                                                           --
-------------------------------------------------------------------------------
--          written by Shotaro Fujimoto (https://github.com/ssh0)            --
-------------------------------------------------------------------------------
-- Import modules                                                           {{{
-------------------------------------------------------------------------------
import qualified Data.Map as M

import XMonad
import qualified XMonad.StackSet as W  -- myManageHookShift

import Control.Monad (liftM2)          -- myManageHookShift
import System.IO                       -- for xmobar

import XMonad.Actions.WindowGo
import XMonad.Actions.FloatKeys
import XMonad.Actions.CycleWS
import XMonad.Actions.UpdatePointer
import qualified XMonad.Actions.FlexibleResize as Flex -- Resize floating windows from any corner
import XMonad.Hooks.DynamicLog         -- for xmobar
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeWindows
import XMonad.Hooks.ManageDocks        -- avoid xmobar area
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.Place
import XMonad.Layout
-- import XMonad.Layout.DecorationMadness
import XMonad.Layout.DragPane          -- see only two window
import XMonad.Layout.Gaps
import XMonad.Layout.Grid
import XMonad.Layout.IM
import qualified XMonad.Layout.Magnifier as Mag  -- this makes window bigger
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
-- import XMonad.Layout.Named
import XMonad.Layout.NoBorders         -- In Full mode, border is no use
import XMonad.Layout.PerWorkspace      -- Configure layouts on a per-workspace
import XMonad.Layout.ResizableTile     -- Resizable Horizontal border
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing           -- this makes smart space around windows
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns      -- for many windows
import XMonad.Layout.ToggleLayouts     -- Full window at any time
import XMonad.Layout.TwoPane
import XMonad.Prompt
import XMonad.Prompt.Window            -- pops up a prompt with window names
import XMonad.Util.EZConfig            -- removeKeys, additionalKeys
import XMonad.Util.Run(spawnPipe)      -- spawnPipe, hPutStrLn
import XMonad.Util.Run

import Graphics.X11.ExtraTypes.XF86

--------------------------------------------------------------------------- }}}
-- local variables                                                          {{{
-------------------------------------------------------------------------------

myWorkspaces = ["1", "2", "3", "4", "5"]
modm = mod4Mask

-- Color Setting
colorBlue      = "#9fc7e8"
colorGreen     = "#a5d6a7"
colorRed       = "#ef9a9a"
colorGray      = "#9e9e9e"
colorWhite     = "#ffffff"
colorGrayAlt   = "#eceff1"
colorNormalbg  = "#1c1c1c"
colorfg        = "#9fa8b1"

-- Border width
borderwidth = 3

-- gapwidth
gapWidth = 6
gapWidthU = 21
gapWidthD = 21
gapWidthL = 10
gapWidthR = 10
-- gapWidthU = 17
-- gapWidthD = 17
-- gapWidthL = 13
-- gapWidthR = 13

--------------------------------------------------------------------------- }}}
-- Define keys to remove                                                    {{{
-------------------------------------------------------------------------------

keysToRemove x =
    [
        -- Unused gmrun binding
          (modm .|. shiftMask, xK_p)
        -- Unused close window binding
        , (modm .|. shiftMask, xK_c)
        , (modm .|. shiftMask, xK_Return)
    ]

-- Delete the keys combinations we want to remove.
strippedKeys x = foldr M.delete (keys defaultConfig x) (keysToRemove x)

--------------------------------------------------------------------------- }}}
-- main                                                                     {{{
-------------------------------------------------------------------------------

main :: IO ()

main = do
    wsbar <- spawnPipe myWsBar
    xmonad $ ewmh defaultConfig
       { borderWidth        = borderwidth
       , terminal           = "urxvtc"
       , focusFollowsMouse  = True
       , normalBorderColor  = colorNormalbg
       , focusedBorderColor = colorWhite
       , startupHook        = myStartupHook
       , manageHook         = myManageHookShift <+>
                              myManageHookFloat <+>
                              manageDocks
        -- any time Full mode, avoid xmobar area
       , layoutHook         = toggleLayouts (noBorders Full) $
                              avoidStruts $
                              onWorkspace "3" simplestFloat $
                              myLayout
        -- xmobar setting
       , logHook            = myLogHook wsbar
       , handleEventHook    = fadeWindowsEventHook
       , workspaces         = myWorkspaces
       , modMask            = modm
       , mouseBindings      = newMouse
       }

       -------------------------------------------------------------------- }}}
       -- Keymap: window operations                                         {{{
       ------------------------------------------------------------------------

       `additionalKeys`
       [ ((modm                , xK_h      ), sendMessage Shrink)
       , ((modm                , xK_l      ), sendMessage Expand)
       , ((modm                , xK_z      ), sendMessage MirrorShrink)
       , ((modm                , xK_a      ), sendMessage MirrorExpand)
       , ((modm                , xK_c      ), kill) -- Close the focused window
       , ((modm                , xK_f      ), sendMessage ToggleLayout)
       , ((modm .|. shiftMask  , xK_f      ), withFocused (keysMoveWindow (-borderwidth, -borderwidth)))
       , ((modm .|. controlMask, xK_Right  ), withFocused (keysMoveWindow (6,0)))
       , ((modm .|. controlMask, xK_Left   ), withFocused (keysMoveWindow (-6,0)))
       , ((modm .|. controlMask, xK_Up     ), withFocused (keysMoveWindow (0,-6)))
       , ((modm .|. controlMask, xK_Down   ), withFocused (keysMoveWindow (0,6)))
       , ((modm                , xK_s      ), withFocused (keysResizeWindow (-12,-12) (0.5,0.5))) -- shrink window
       , ((modm                , xK_i      ), withFocused (keysResizeWindow (12,12) (0.5,0.5))) -- increase window
       , ((modm .|. controlMask, xK_l      ), withFocused (keysResizeWindow (6,0) (0,0)))
       , ((modm .|. controlMask, xK_h      ), withFocused (keysResizeWindow (-6,0) (0,0)))
       , ((modm .|. controlMask, xK_a      ), withFocused (keysResizeWindow (0,-6) (0,0)))
       , ((modm .|. controlMask, xK_z      ), withFocused (keysResizeWindow (0,6) (0,0)))
       , ((modm                , xK_Right  ), nextWS ) -- go to next workspace
       , ((modm                , xK_Left   ), prevWS ) -- go to prev workspace
       , ((modm .|. shiftMask  , xK_Right  ), shiftToNext)
       , ((modm .|. shiftMask  , xK_Left   ), shiftToPrev)
       , ((modm                , xK_comma  ), sendMessage Mag.MagnifyLess) -- smaller window
       , ((modm                , xK_period ), sendMessage Mag.MagnifyMore) -- bigger window
       , ((modm                , xK_j      ), windows W.focusDown)
       , ((modm                , xK_k      ), windows W.focusUp)
       , ((modm .|. shiftMask  , xK_j      ), windows W.swapDown)
       , ((modm .|. shiftMask  , xK_k      ), windows W.swapUp)
       , ((modm .|. shiftMask  , xK_m      ), windows W.shiftMaster)
       , ((modm                , xK_g      ), windowPromptGoto myXPConfig)
       , ((modm                , xK_b      ), windowPromptBring myXPConfig)
       , ((modm                , xK_w      ), nextScreen)
       ]

       -------------------------------------------------------------------- }}}
       -- Keymap: moving workspace by number                                {{{
       ------------------------------------------------------------------------

       `additionalKeys`
       [ ((modm .|. m, k), windows $ f i)
         | (i, k) <- zip myWorkspaces
                     [ xK_exclam, xK_at, xK_numbersign
                     , xK_dollar, xK_percent, xK_asciicircum
                     , xK_ampersand, xK_asterisk, xK_parenleft
                     , xK_parenright
                     ]
         , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
       ]

       -------------------------------------------------------------------- }}}
       -- Keymap: custom commands                                           {{{
       ------------------------------------------------------------------------

       `additionalKeys`
       [ ((mod1Mask .|. controlMask, xK_l      ), spawn "xscreensaver-command -lock")
       , ((mod1Mask .|. controlMask, xK_t      ), spawn "bash $HOME/bin/toggle_compton.sh")
       , ((modm                    , xK_Return ), spawn "urxvtc")
       , ((modm .|. shiftMask      , xK_Return ), spawn "sh $HOME/bin/urxvt_float.sh")
       , ((modm                    , xK_e      ), spawn "python $HOME/Workspace/python/transparent.py")
       , ((modm                    , xK_p      ), spawn "exe=`dmenu_run -b -p '#' -nb '#009688' -nf '#ffffff' -sb '#ffffff' -sf '#000000'` && exec $exe")
       , ((mod1Mask .|. controlMask, xK_f      ), spawn "python $HOME/Workspace/python/web_search/websearch.py")
       , ((mod1Mask .|. controlMask, xK_s      ), spawn "python $HOME/Workspace/python/web_search/hlsearch.py")
       , ((0                       , 0x1008ff18), spawn "sh $HOME/bin/cplay.sh")
       , ((0                       , 0x1008ff14), spawn "sh $HOME/bin/cplay.sh")
       , ((0                       , 0x1008ff13), spawn "bash $HOME/bin/sound_volume_change_wrapper.sh +")
       , ((0                       , 0x1008ff11), spawn "bash $HOME/bin/sound_volume_change_wrapper.sh -")
       , ((0                       , 0x1008ff12), spawn "bash $HOME/bin/sound_volume_change_wrapper.sh m")
        -- Brightness Keys
       , ((0                       , 0x1008FF02), spawn "xbacklight + 1 -time 100 -steps 1")
       , ((0                       , 0x1008FF03), spawn "xbacklight - 1 -time 100 -steps 1")
       , ((0                       , 0xff61    ), spawn "sh $HOME/bin/screenshot.sh")
       , ((shiftMask               , 0xff61    ), spawn "sh $HOME/bin/screenshot_select.sh")
       , ((0                       , 0x1008ff1d), spawn "ipython qtconsole --matplotlib=inline")
       , ((controlMask             , xK_Escape ), spawn "bash $HOME/bin/touchpad_toggle.sh")
       , ((mod1Mask                , xK_Escape ), spawn "bash $HOME/bin/trackpoint_toggle.sh")
       ]

--------------------------------------------------------------------------- }}}
-- myLayout:          Handle Window behaveior                               {{{
-------------------------------------------------------------------------------

myLayout = spacing gapWidth $ gaps [(U,gapWidth + gapWidthU),(D,gapWidth + gapWidthD),(L,gapWidth + gapWidthL),(R,gapWidth + gapWidthR)] $
                 (ResizableTall 1 (1/100) (4/7) [])
             ||| (TwoPane (1/100) (4/7))
             ||| (ThreeColMid 1 (1/100) (16/35))
             ||| (ResizableTall 2 (1/100) (1/2) [])
--             |||  Mag.magnifiercz 1.1 (spacing 6 $ GridRatio (4/3))

--------------------------------------------------------------------------- }}}
-- myStartupHook:     Start up applications                                 {{{
-------------------------------------------------------------------------------

myStartupHook = do
        spawn "gnome-settings-daemon"
        spawn "nm-applet"
        spawn "xscreensaver -no-splash"
        spawn "$HOME/.dropbox-dist/dropboxd"
        spawn "bash $HOME/.fehbg"
        spawn "bash $HOME/bin/toggle_compton.sh"
        spawn "bash $HOME/bin/start_urxvtd.sh"

--------------------------------------------------------------------------- }}}
-- myManageHookShift: some window must created there                        {{{
-------------------------------------------------------------------------------

myManageHookShift = composeAll
            -- if you want to know className, type "$ xprop|grep CLASS" on shell
            [ className =? "Firefox"       --> mydoShift "2"
            , className =? "Google-chrome" --> mydoShift "4"
            ]
             where mydoShift = doF . liftM2 (.) W.greedyView W.shift

--------------------------------------------------------------------------- }}}
-- myManageHookFloat: new window will created in Float mode                 {{{
-------------------------------------------------------------------------------

myManageHookFloat = composeAll
    [ className =? "Gimp"             --> doFloat
    , className =? "mplayer2"         --> doCenterFloat
    , className =? "mpv"              --> doCenterFloat
    , className =? "Tk"               --> doFloat
    , className =? "Screenkey"        --> (doRectFloat $ W.RationalRect 0.7 0.9 0.3 0.1)
    , className =? "feh"              --> doCenterFloat
    , className =? "Display.im6"      --> doCenterFloat
    , className =? "Shutter"          --> doCenterFloat
    , className =? "Thunar"           --> doCenterFloat
    , className =? "Websearch.py"     --> (doRectFloat $ W.RationalRect 0.45 0.4 0.1 0.01)
    , title     =? "urxvt_float"      --> doCenterFloat
    , className =? "Plugin-container" --> doCenterFloat

    , title     =? "Speedbar"         --> doCenterFloat
    , stringProperty "WM_NAME" =? "tmptex.pdf - 1/1 (96 dpi)" --> (doRectFloat $ W.RationalRect 0.29 0.25 0.42 0.5)
    ]

--------------------------------------------------------------------------- }}}
-- myLogHook:         loghock settings                                      {{{
-------------------------------------------------------------------------------

myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }

--------------------------------------------------------------------------- }}}
-- myWsBar:           xmobar setting                                        {{{
-------------------------------------------------------------------------------

myWsBar = "xmobar $HOME/.xmonad/xmobarrc"

wsPP = xmobarPP { ppOrder           = \(ws:l:t:_)  -> [ws]
                , ppCurrent         = xmobarColor colorGreen colorNormalbg . \s -> " ● "
                , ppUrgent          = xmobarColor colorfg    colorNormalbg . \s -> " ● "
                , ppVisible         = xmobarColor colorfg    colorNormalbg . \s -> " ● "
                , ppHidden          = xmobarColor colorfg    colorNormalbg . \s -> " ● "
                , ppHiddenNoWindows = xmobarColor colorfg    colorNormalbg . \s -> " ○ "
                , ppTitle           = xmobarColor colorGreen colorNormalbg
                , ppOutput          = putStrLn
                , ppWsSep           = ""
                , ppSep             = " : "
                }

--------------------------------------------------------------------------- }}}
-- myXPConfig:        XPConfig                                            {{{

myXPConfig = defaultXPConfig
                { font              = "xft:TakaoGothic:size=12:antialias=true"
                , fgColor           = colorfg
                , bgColor           = colorNormalbg
                , borderColor       = colorNormalbg
                , height            = 20
                , promptBorderWidth = 1
                , autoComplete      = Just 100000
                , bgHLight          = colorWhite
                , fgHLight          = colorNormalbg
                , position          = Bottom
                }

--------------------------------------------------------------------------- }}}
-- newMouse:          Right click is used for resizing window               {{{
-------------------------------------------------------------------------------

myMouse x = [ ((modm, button3), (\w -> focus w >> Flex.mouseResizeWindow w)) ]
newMouse x = M.union (mouseBindings defaultConfig x) (M.fromList (myMouse x))

--------------------------------------------------------------------------- }}}
