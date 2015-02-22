import qualified Data.Map as M

import XMonad
import qualified XMonad.StackSet as W  -- myManageHookShift

import Control.Monad (liftM2)          -- myManageHookShift
import System.IO                       -- for xmobar

import XMonad.Actions.WindowGo
import XMonad.Actions.FloatKeys
import XMonad.Actions.CycleWS
import qualified XMonad.Actions.FlexibleResize as Flex  -- Resize floating windows from any corner
import XMonad.Hooks.DynamicLog         -- for xmobar
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeWindows
import XMonad.Hooks.ManageDocks        -- avoid xmobar area
import XMonad.Hooks.Place
import XMonad.Layout
import XMonad.Layout.DecorationMadness
import XMonad.Layout.DragPane          -- see only two window
import XMonad.Layout.Gaps
import XMonad.Layout.Grid
import XMonad.Layout.IM
import qualified XMonad.Layout.Magnifier as Mag -- this makes window bigger
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.Named
import XMonad.Layout.NoBorders         -- In Full mode, border is no use
import XMonad.Layout.PerWorkspace      -- Configure layouts on a per-workspace
import XMonad.Layout.ResizableTile     -- Resizable Horizontal border
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing           -- this makes smart space around windows
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns      -- for many windows
import XMonad.Layout.ToggleLayouts     -- Full window at any time
import XMonad.Util.EZConfig            -- removeKeys, additionalKeys
import XMonad.Util.Run(spawnPipe)      -- spawnPipe, hPutStrLn
import XMonad.Util.Run

import Graphics.X11.ExtraTypes.XF86

myWorkspaces = ["  main  ", "  browser  ", "  float  ", "  work  ", "  tray  "]
modm = mod4Mask

-- Color Setting
colorBlue      = "#90caf9"
colorGreen     = "#a5d6a7"
colorRed       = "#ef9a9a"
colorGray      = "#9e9e9e"
colorWhite     = "#ffffff"
colorGrayAlt   = "#eceff1"
colorNormalbg  = "#212121"
colorfg        = "#9fa8b1"

-- Border width
borderwidth = 0

-- Define keys to remove
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

main :: IO ()

main = do
    wsbar <- spawnPipe myWsBar
    xmonad $ defaultConfig
       { borderWidth        = borderwidth
       , terminal           = "urxvt"
       , focusFollowsMouse  = False
       , normalBorderColor  = "#212121"
       , focusedBorderColor = colorWhite
       , startupHook        = myStartupHook
       , manageHook         = placeHook myPlacement <+>
                              myManageHookShift <+>
                              myManageHookFloat <+>
                              manageDocks
        -- any time Full mode, avoid xmobar area
       , layoutHook         = toggleLayouts (noBorders Full) $
                              avoidStruts $
                              onWorkspace "  float  " simplestFloat $
                              myLayout
        -- xmobar setting
       , logHook            = myLogHook wsbar
       , handleEventHook    = fadeWindowsEventHook
       , workspaces         = myWorkspaces
       , modMask            = modm
       , mouseBindings      = newMouse
       }

       `additionalKeys`
       [ ((modm                , xK_h      ), sendMessage Shrink)
       , ((modm                , xK_l      ), sendMessage Expand)
       , ((modm                , xK_f      ), sendMessage ToggleLayout)
       , ((modm .|. shiftMask  , xK_f      ), withFocused (keysMoveWindow (-borderwidth, -borderwidth)))
       , ((modm                , xK_z      ), sendMessage MirrorShrink)
       , ((modm                , xK_a      ), sendMessage MirrorExpand)
       , ((modm                , xK_Right  ), nextWS ) -- go to next workspace
       , ((modm                , xK_Left   ), prevWS ) -- go to prev workspace
       , ((modm .|. shiftMask  , xK_Right  ), shiftToNext)
       , ((modm .|. shiftMask  , xK_Left   ), shiftToPrev)
       , ((modm .|. controlMask, xK_Right  ), withFocused (keysMoveWindow (30, 0)))
       , ((modm .|. controlMask, xK_Left   ), withFocused (keysMoveWindow (-30, 0)))
       , ((modm .|. controlMask, xK_Up     ), withFocused (keysMoveWindow (0, -30)))
       , ((modm .|. controlMask, xK_Down   ), withFocused (keysMoveWindow (0, 30)))
       , ((modm                , xK_comma  ), sendMessage Mag.MagnifyLess) -- smaller window
       , ((modm                , xK_period ), sendMessage Mag.MagnifyMore) -- bigger window
       , ((modm                , xK_j      ), windows W.focusDown)
       , ((modm                , xK_k      ), windows W.focusUp)
       , ((modm .|. shiftMask  , xK_j      ), windows W.swapDown)
       , ((modm .|. shiftMask  , xK_k      ), windows W.swapUp)
       , ((modm .|. shiftMask  , xK_m      ), windows W.shiftMaster)
       , ((modm                , xK_w      ), nextScreen) ]

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

       `additionalKeys`
       [ ((mod1Mask .|. controlMask, xK_l      ), spawn "xscreensaver-command -lock")
       , ((mod1Mask .|. controlMask, xK_t      ), spawn "bash /home/shotaro/bin/toggle_compton.sh")
       , ((modm                    , xK_Return ), spawn "urxvt")
       , ((modm                    , xK_c      ), kill) -- %! Close the focused window
       , ((modm                    , xK_p      ), spawn "exe=`dmenu_run -b -nb '#009688' -nf '#ffffff' -sb '#ffffff' -sf '#000000'` && exec $exe")
       , ((mod1Mask .|. controlMask, xK_f      ), spawn "python /home/shotaro/Workspace/python/web_search/websearch.py")
       , ((0                       , 0x1008ff14), spawn "sh /home/shotaro/bin/cplay.sh")
       , ((0                       , 0x1008ff13), spawn "amixer -D pulse set Master 1%+ && paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga")
       , ((0                       , 0x1008ff11), spawn "amixer -D pulse set Master 1%- && paplay /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga")
       , ((0                       , 0x1008ff12), spawn "amixer -D pulse set Master toggle")
        -- Brightness Keys
       , ((0                       , 0x1008FF02), spawn "xbacklight + 10 -time 100 -steps 5")
       , ((0                       , 0x1008FF03), spawn "xbacklight - 10 -time 100 -steps 5")
       , ((0                       , 0xff61    ), spawn "sh /home/shotaro/bin/screenshot.sh")
       , ((shiftMask               , 0xff61    ), spawn "sh /home/shotaro/bin/screenshot_select.sh")
       , ((modm     .|. controlMask, xK_h      ), spawn "sh /home/shotaro/bin/xte-left.sh")
       , ((modm     .|. controlMask, xK_l      ), spawn "sh /home/shotaro/bin/xte-right.sh")
       , ((modm     .|. controlMask, xK_j      ), spawn "sh /home/shotaro/bin/xte-down.sh")
       , ((modm     .|. controlMask, xK_k      ), spawn "sh /home/shotaro/bin/xte-up.sh")
       , ((modm     .|. controlMask, xK_Return ), spawn "sh /home/shotaro/bin/xte-click.sh")

       ]

-- Handle Window behaveior
myLayout = (spacing 18 $ ResizableTall 1 (1/100) (1/2) [])
             |||  (spacing 18 $ ThreeCol 1 (1/100) (16/35))
             |||  (spacing 18 $ ResizableTall 2 (1/100) (1/2) [])
--             |||  Mag.magnifiercz 1.1 (spacing 6 $ GridRatio (4/3))

-- Start up (at xmonad beggining), like "wallpaper" or so on
myStartupHook = do
        spawn "gnome-settings-daemon"
        spawn "nm-applet"
        spawn "gnome-sound-applet"
        spawn "xscreensaver -no-splash"
        spawn "/home/shotaro/.dropbox-dist/dropboxd"
        spawn "feh --bg-fill '/home/shotaro/Downloads/20 Free Modern Backgrounds/20 Low-Poly Backgrounds/Low-Poly Backgrounds (2).JPG'"
        spawn "bash /home/shotaro/bin/toggle_compton.sh"
        -- spawn "compton -b --config /home/shotaro/.config/compton/compton.conf"

-- some window must created there
myManageHookShift = composeAll
            -- if you want to know className, type "$ xprop|grep CLASS" on shell
            [ className =? "Firefox"       --> mydoShift "  browser  "
            , className =? "Google-chrome" --> mydoShift "  work  "
            ]
             where mydoShift = doF . liftM2 (.) W.greedyView W.shift

-- new window will created in Float mode
myManageHookFloat = composeAll
            [ className =? "Gimp"             --> doFloat,
              className =? "mplayer2"         --> doFloat,
              className =? "Tk"               --> doFloat,
              className =? "Display.im6"      --> doFloat,
              className =? "Shutter"          --> doFloat,
              className =? "Websearch.py"     --> doFloat,
              className =? "Plugin-container" --> doFloat,
              title     =? "Speedbar"         --> doFloat]


myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }

myWsBar = "xmobar /home/shotaro/.xmonad/xmobarrc"

wsPP = xmobarPP { ppOrder           = \(ws:l:t:_)  -> [ws,t]
                , ppCurrent         = xmobarColor  colorGreen    colorNormalbg
                , ppUrgent          = xmobarColor  colorWhite    colorNormalbg
                , ppVisible         = xmobarColor  colorWhite    colorNormalbg
                , ppHidden          = xmobarColor  colorWhite    colorNormalbg
                , ppHiddenNoWindows = xmobarColor  colorfg       colorNormalbg
                , ppTitle           = xmobarColor  colorGreen    colorNormalbg
                , ppOutput          = putStrLn
                , ppWsSep           = ""
                , ppSep             = " : "
                }

-- Right click is used for resizing window
myMouse x = [ ((modm, button3), (\w -> focus w >> Flex.mouseResizeWindow w)) ]
newMouse x = M.union (mouseBindings defaultConfig x) (M.fromList (myMouse x))

myPlacement = fixed (0.5, 0.5)
