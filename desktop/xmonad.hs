import XMonad hiding (Tall)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.ThreeColumns
import XMonad.Layout.HintedTile
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.DynamicLog
import System.IO

myLayout = avoidStruts $
         smartBorders $
         hintedTile Tall |||
         hintedTile Wide |||
         noBorders Full  |||
	 Grid

  -- hintedTile listens to application hints, so as not to break gVim.
  where
     hintedTile = HintedTile nmaster delta ratio TopLeft
     threeCol   = ThreeCol nmaster delta ratio
     nmaster    = 1
     delta      = 3/100
     ratio      = 1/2

myManageHook = composeAll
    [
        className =? "Gimp" --> doFloat
        , className =? "VNC" --> doFloat
        , className =? "VLC" --> doFloat
        , className =? "Firefox" --> doShift "1"
	, className =? "Chrome" --> doShift "1"
        , className =? "Thunderbird" --> doShift "3"
        , className =? "MonoDevelop" --> doShift "4"
        , className =? "Emacs" --> doShift "4"
        , className =? "MPlayer" --> doFloat
        , className =? "Skype" --> doShift "5"
        , className =? "Pidgin" --> doShift "5"
        , className =? "Spotify" --> doShift "9"
        --, isFullscreen --> doFullFloat
        , manageDocks
   ]


main = do
    xmproc <- spawnPipe "xmobar /home/archie/.xmonad/xmobar.rc"
    xmonad $ defaultConfig
        {
          modMask = mod1Mask
--      , focusFollowsMouse = True
--      , workspaces         = myWorkspaces
--      , normalBorderColor  = "#444"
--      , FOCUSEDBorderColor = "#f00"
        , workspaces = ["1","2","3","4","5","6","7","8","9","0"]
        , manageHook = myManageHook <+> manageHook defaultConfig	 

	-- I used to use: avoidStruts $ layoutHook defaultConfig
        , layoutHook = myLayout

	, logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
			}

        -- This hack is necessary to make Java GUIs like NetBeans work.  See the FAQ.
        --, logHook = setWMName "LG3D"
        } `removeKeysP` ["M-w"]

