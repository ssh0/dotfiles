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
import Control.Monad (liftM2)          -- myManageHookShift
import Data.Monoid
import System.IO                       -- for xmobar

import XMonad
import qualified XMonad.StackSet as W  -- myManageHookShift

import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import qualified XMonad.Actions.FlexibleResize as Flex -- flexible resize
import XMonad.Actions.FloatKeys
import XMonad.Actions.UpdatePointer
import XMonad.Actions.WindowGo

import XMonad.Hooks.DynamicLog         -- for xmobar
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks        -- avoid xmobar area
import XMonad.Hooks.ManageHelpers

import XMonad.Layout
import XMonad.Layout.DragPane          -- see only two window
import XMonad.Layout.Gaps
import XMonad.Layout.NoBorders         -- In Full mode, border is no use
import XMonad.Layout.PerWorkspace      -- Configure layouts on a per-workspace
import XMonad.Layout.ResizableTile     -- Resizable Horizontal border
import XMonad.Layout.Simplest
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing           -- this makes smart space around windows
import XMonad.Layout.ToggleLayouts     -- Full window at any time
import XMonad.Layout.TwoPane

import XMonad.Prompt
import XMonad.Prompt.Window            -- pops up a prompt with window names
import XMonad.Util.EZConfig            -- removeKeys, additionalKeys
import XMonad.Util.Run
import XMonad.Util.Run(spawnPipe)      -- spawnPipe, hPutStrLn
import XMonad.Util.SpawnOnce

import Graphics.X11.ExtraTypes.XF86

--------------------------------------------------------------------------- }}}
-- local variables                                                          {{{
-------------------------------------------------------------------------------

myWorkspaces = ["1", "2", "3", "4", "5"]
modm = mod4Mask

-- Color Setting
colorBlue      = "#868bae"
colorGreen     = "#00d700"
colorRed       = "#ff005f"
colorGray      = "#666666"
colorWhite     = "#bdbdbd"
colorNormalbg  = "#1c1c1c"
colorfg        = "#a8b6b8"

-- Border width
borderwidth = 0

-- Border color
mynormalBorderColor  = "#333333"
myfocusedBorderColor = "#585858"

-- Float window control width
moveWD = borderwidth
resizeWD = 2*borderwidth

-- gapwidth
gapwidth  = 5
gwU = 5
gwD = 4
gwL = 35
gwR = 34

--------------------------------------------------------------------------- }}}
-- main                                                                     {{{
-------------------------------------------------------------------------------

main :: IO ()

main = do
    wsbar <- spawnPipe myWsBar
    xmonad $ ewmh defaultConfig
       { borderWidth        = borderwidth
       , terminal           = "urxvt"
       , focusFollowsMouse  = True
       , normalBorderColor  = mynormalBorderColor
       , focusedBorderColor = myfocusedBorderColor
       , startupHook        = myStartupHook
       , manageHook         = myManageHookShift <+>
                              myManageHookFloat <+>
                              manageDocks
       , layoutHook         = avoidStruts $ ( toggleLayouts (noBorders Full)
                                            $ onWorkspace "3" simplestFloat
                                            $ myLayout
                                            )
        -- xmobar setting
       , logHook            = myLogHook wsbar
                                >> updatePointer (Relative 0.5 0.5)
       , handleEventHook    = fullscreenEventHook
       , workspaces         = myWorkspaces
       , modMask            = modm
       , mouseBindings      = newMouse
       }

       -------------------------------------------------------------------- }}}
       -- Define keys to remove                                             {{{
       ------------------------------------------------------------------------

       `removeKeysP`
       [
       -- Unused gmrun binding
       "M-S-p",
       -- Unused close window binding
       "M-S-c",
       "M-S-<Return>"
       ]

       -------------------------------------------------------------------- }}}
       -- Keymap: window operations                                         {{{
       ------------------------------------------------------------------------

       `additionalKeysP`
       [
       -- Shrink / Expand the focused window
         ("M-,"    , sendMessage Shrink)
       , ("M-."    , sendMessage Expand)
       , ("M-z"    , sendMessage MirrorShrink)
       , ("M-a"    , sendMessage MirrorExpand)
       -- Close the focused window
       , ("M-c"    , kill1)
       -- Toggle layout (Fullscreen mode)
       , ("M-f"    , sendMessage ToggleLayout)
       , ("M-S-f"  , withFocused (keysMoveWindow (-borderwidth,-borderwidth)))
       -- Move the focused window
       , ("M-C-<R>", withFocused (keysMoveWindow (moveWD, 0)))
       , ("M-C-<L>", withFocused (keysMoveWindow (-moveWD, 0)))
       , ("M-C-<U>", withFocused (keysMoveWindow (0, -moveWD)))
       , ("M-C-<D>", withFocused (keysMoveWindow (0, moveWD)))
       -- Resize the focused window
       , ("M-s"    , withFocused (keysResizeWindow (-resizeWD, resizeWD) (0.5, 0.5)))
       , ("M-i"    , withFocused (keysResizeWindow (resizeWD, resizeWD) (0.5, 0.5)))
       -- Increase / Decrese the number of master pane
       , ("M-S-;"  , sendMessage $ IncMasterN 1)
       , ("M--"    , sendMessage $ IncMasterN (-1))
       -- Go to the next / previous workspace
       , ("M-<R>"  , nextWS )
       , ("M-<L>"  , prevWS )
       , ("M-l"    , nextWS )
       , ("M-h"    , prevWS )
       -- Shift the focused window to the next / previous workspace
       , ("M-S-<R>", shiftToNext)
       , ("M-S-<L>", shiftToPrev)
       , ("M-S-l"  , shiftToNext)
       , ("M-S-h"  , shiftToPrev)
       -- CopyWindow
       , ("M-v"    , windows copyToAll)
       , ("M-S-v"  , killAllOtherCopies)
       -- Move the focus down / up
       , ("M-<D>"  , windows W.focusDown)
       , ("M-<U>"  , windows W.focusUp)
       , ("M-j"    , windows W.focusDown)
       , ("M-k"    , windows W.focusUp)
       -- Swap the focused window down / up
       , ("M-S-j"  , windows W.swapDown)
       , ("M-S-k"  , windows W.swapUp)
       -- Shift the focused window to the master window
       , ("M-S-m"  , windows W.shiftMaster)
       -- Search a window and focus into the window
       , ("M-g"    , windowPromptGoto myXPConfig)
       -- Search a window and bring to the current workspace
       , ("M-b"    , windowPromptBring myXPConfig)
       -- Move the focus to next screen (multi screen)
       , ("M-<Tab>", nextScreen)
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

       `additionalKeysP`
       [
       -- Lock screen
         ("M1-C-l", spawn "xscreensaver-command -lock")
       -- Toggle compton (compsite manager)
       , ("M1-C-t", spawn "bash toggle_compton.sh")
       -- Launch terminal
       , ("M-<Return>", spawn "urxvt")
       -- Launch terminal with a float window
       , ("M-S-<Return>", spawn "urxvt_float.sh")
       -- Insert a transparent panel
       , ("M-S-t", spawn "python $HOME/Workspace/python/transparent.py")
       -- Launch file manager
       , ("M-e", spawn "thunar")
       -- Launch web browser
       , ("M-w", spawn "luakit")
       -- Launch dmenu for launching applicatiton
       , ("M-p", spawn "exe=`dmenu_run -l 10 -fn 'Migu 1M:size=20'` && exec $exe")
       -- Lauch websearch application (See https://github.com/ssh0/web_search)
       , ("M1-C-f", spawn "websearch")
       -- Play / Pause media keys
       , ("<XF86AudioPlay>"  , spawn "mpc toggle")
       , ("<XF86HomePage>"   , spawn "mpc toggle")
       , ("S-<F6>"           , spawn "mpc toggle")
       , ("S-<XF86AudioPlay>", spawn "streamradio pause")
       , ("S-<XF86HomePage>" , spawn "streamradio pause")
       -- Volume setting media keys
       , ("<XF86AudioRaiseVolume>", spawn "sound_volume_change_wrapper.sh +")
       , ("<XF86AudioLowerVolume>", spawn "sound_volume_change_wrapper.sh -")
       , ("<XF86AudioMute>"       , spawn "sound_volume_change_wrapper.sh m")
        -- Brightness Keys
       , ("<XF86MonBrightnessUp>"  , spawn "xbacklight + 5 -time 100 -steps 1")
       , ("<XF86MonBrightnessDown>", spawn "xbacklight - 5 -time 100 -steps 1")
       -- Take a screenshot (whole window)
       , ("<Print>", spawn "screenshot.sh")
       -- Take a screenshot (selected area)
       , ("S-<Print>", spawn "screenshot_select.sh")
       -- Launch ipython qtconsole
       , ("<XF86Calculator>", spawn "ipython qtconsole --matplotlib=inline")
       -- Toggle touchpad
       , ("C-<Escape>", spawn "touchpad_toggle.sh")
       -- Toggle trackpoint (Lenovo PC)
       , ("M1-<Escape>", spawn "trackpoint_toggle.sh")
       ]

--------------------------------------------------------------------------- }}}
-- myLayout:          Handle Window behaveior                               {{{
-------------------------------------------------------------------------------

myLayout = spacing gapwidth $ gaps [(U, gwU),(D, gwD),(L, gwL),(R, gwR)]
           $ Simplest

--------------------------------------------------------------------------- }}}
-- myStartupHook:     Start up applications                                 {{{
-------------------------------------------------------------------------------

myStartupHook = do
        spawnOnce "gnome-settings-daemon"
        spawnOnce "nm-applet"
        spawnOnce "xscreensaver -no-splash"
        spawnOnce "$HOME/.dropbox-dist/dropboxd"
        spawnOnce "bash $HOME/.fehbg"
        -- spawnOnce "compton -b --config $HOME/.config/compton/compton.conf"

--------------------------------------------------------------------------- }}}
-- myManageHookShift: some window must created there                        {{{
-------------------------------------------------------------------------------

myManageHookShift = composeAll
            -- if you want to know className, type "$ xprop|grep CLASS" on shell
            [ className =? "Firefox"       --> mydoShift "2"
            ]
             where mydoShift = doF . liftM2 (.) W.greedyView W.shift

--------------------------------------------------------------------------- }}}
-- myManageHookFloat: new window will created in Float mode                 {{{
-------------------------------------------------------------------------------

myManageHookFloat = composeAll
    [ className =? "Gimp"             --> doFloat
    , className =? "Tk"               --> doFloat
    , className =? "mplayer2"         --> doCenterFloat
    , className =? "mpv"              --> doCenterFloat
    , className =? "feh"              --> doCenterFloat
    , className =? "Display.im6"      --> doCenterFloat
    , className =? "Shutter"          --> doCenterFloat
    , className =? "Thunar"           --> doCenterFloat
    , className =? "Nautilus"         --> doCenterFloat
    , className =? "Plugin-container" --> doCenterFloat
    , className =? "Screenkey"        --> (doRectFloat $ W.RationalRect 0.7 0.9 0.3 0.1)
    , className =? "Websearch"        --> doCenterFloat
    , className =? "XClock"           --> doSideFloat NE
    , title     =? "Speedbar"         --> doCenterFloat
    , title     =? "urxvt_float"      --> doSideFloat SC
    , isFullscreen                    --> doFullFloat
    , isDialog                        --> doCenterFloat
    , stringProperty "WM_NAME" =? "LINE" --> (doRectFloat $ W.RationalRect 0.60 0.1 0.39 0.82)
    , stringProperty "WM_NAME" =? "Google Keep" --> (doRectFloat $ W.RationalRect 0.3 0.1 0.4 0.82)
    , stringProperty "WM_NAME" =? "tmptex.pdf - 1/1 (96 dpi)" --> doCenterFloat
    ]

--------------------------------------------------------------------------- }}}
-- myLogHook:         loghock settings                                      {{{
-------------------------------------------------------------------------------

myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }

--------------------------------------------------------------------------- }}}
-- myWsBar:           xmobar setting                                        {{{
-------------------------------------------------------------------------------

myWsBar = "xmobar $HOME/.xmonad/xmobarrc"

wsPP = xmobarPP { ppOrder           = \(ws:l:t:_)  -> [ws,t]
                , ppCurrent         = xmobarColor colorRed     colorNormalbg . \s -> "●"
                , ppUrgent          = xmobarColor colorGray    colorNormalbg . \s -> "●"
                , ppVisible         = xmobarColor colorRed     colorNormalbg . \s -> "⦿"
                , ppHidden          = xmobarColor colorGray    colorNormalbg . \s -> "●"
                , ppHiddenNoWindows = xmobarColor colorGray    colorNormalbg . \s -> "○"
                , ppTitle           = xmobarColor colorRed     colorNormalbg
                , ppOutput          = putStrLn
                , ppWsSep           = " "
                , ppSep             = "  "
                }

--------------------------------------------------------------------------- }}}
-- myXPConfig:        XPConfig                                            {{{

myXPConfig = defaultXPConfig
                { font              = "xft:Migu 1M:size=20:antialias=true"
                , fgColor           = colorfg
                , bgColor           = colorNormalbg
                , borderColor       = colorNormalbg
                , height            = 35
                , promptBorderWidth = 0
                , autoComplete      = Just 100000
                , bgHLight          = colorNormalbg
                , fgHLight          = colorRed
                , position          = Bottom
                }

--------------------------------------------------------------------------- }}}
-- newMouse:          Right click is used for resizing window               {{{
-------------------------------------------------------------------------------

myMouse x = [ ((modm, button3), (\w -> focus w >> Flex.mouseResizeWindow w)) ]
newMouse x = M.union (mouseBindings defaultConfig x) (M.fromList (myMouse x))

--------------------------------------------------------------------------- }}}
-- vim: ft=haskell
