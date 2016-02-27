import XMonad
import XMonad.Actions.PhysicalScreens
import XMonad.Actions.UpdatePointer
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.WindowNavigation
import XMonad.Util.EZConfig(additionalKeys)

import qualified XMonad.StackSet as W

myModMask = mod4Mask
myTerminal = "urxvt"
myLayout =
	noBorders (fullscreenFull Full) |||
	Tall 1 (3/100) (1/2)

myConfig = defaultConfig
		{ borderWidth        = 1
		, normalBorderColor  = "#000000"
		, focusedBorderColor = "#007fff"
		, modMask            = myModMask
		, terminal           = myTerminal
		, focusFollowsMouse  = True
		, handleEventHook    = fullscreenEventHook
		, manageHook         = fullscreenManageHook
		, layoutHook         = myLayout
        , logHook            = updatePointer (Relative 0.5 0.5)
		} `additionalKeys`
		[ ((myModMask, xK_x), spawn "xscreensaver-command -lock")
		, ((myModMask .|. shiftMask, xK_x), spawn "xscreensaver-command -lock && xset dpms force off")
		, ((myModMask .|. controlMask, xK_x), spawn "xscreensaver-command -activate")
		, ((myModMask .|. controlMask .|. shiftMask, xK_x), spawn "xscreensaver-command -activate && xset dpms force off")
		, ((myModMask, xK_s), spawn "screenshot win")
		, ((myModMask .|. shiftMask, xK_s), spawn "screenshot scr")
		, ((myModMask, xK_c), spawn "pkill -USR1 redshift")
		, ((myModMask, xK_p), spawn "dmenu_run")
		, ((myModMask, xK_f), spawn "pkill -kill libflash")
		, ((myModMask, xK_m), spawn "urxvt -e ncmpc")
		, ((myModMask .|. mod1Mask, xK_z), spawn "systemctl suspend")
		, ((myModMask .|. mod1Mask .|. shiftMask, xK_z), spawn "systemctl hibernate")
--		, ((myModMask, xK_j), windows W.focusUp)
--		, ((myModMask, xK_k), windows W.focusDown)
--		, ((myModMask .|. shiftMask, xK_j), windows W.swapUp)
--		, ((myModMask .|. shiftMask, xK_k), windows W.swapDown)
		, ((myModMask, xK_w), viewScreen 0)
		, ((myModMask, xK_e), viewScreen 1)
		, ((myModMask, xK_r), viewScreen 2)
		, ((myModMask .|. shiftMask, xK_w), sendToScreen 0)
		, ((myModMask .|. shiftMask, xK_e), sendToScreen 1)
		, ((myModMask .|. shiftMask, xK_r), sendToScreen 2)
		]

main = do
--	xmonad $ myConfig
--	xmonad =<< dzen myConfig
	xmonad =<< xmobar myConfig
