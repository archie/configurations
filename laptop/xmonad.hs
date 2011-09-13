import XMonad hiding (Tall)
import XMonad.Config.Gnome
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.ThreeColumns
import XMonad.Layout.HintedTile
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Util.EZConfig

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
	, className =? "Firefox" --> doShift "1:web"
	, className =? "Thunderbird" --> doShift "3:mail"
	, className =? "MonoDevelop" --> doShift "4:dev"
	, className =? "Emacs" --> doShift "4:dev"
	, className =? "MPlayer" --> doFloat
	, className =? "Skype" --> doShift "5:chat"
	, className =? "Empathy" --> doShift "5:chat"
	, className =? "Spotify" --> doShift "9:spotify"
	--, isFullscreen --> doFullFloat
	, manageDocks
   ]


main = do
    xmonad $ defaultConfig
        { 
         -- Left WIN Key as modifying
          -- rather than Left ALT
          modMask = mod1Mask
--	, focusFollowsMouse = True
--	, workspaces         = myWorkspaces
--	, normalBorderColor  = "#444"
--	, focusedBorderColor = "#f00"
	, workspaces = ["1:web","2:term","3:mail","4:dev","5:chat","6:tmp","7:dvi","8:vid","9:spotify","0"]
        , manageHook = myManageHook <+> manageHook defaultConfig

        -- I used to use: avoidStruts $ layoutHook defaultConfig
        , layoutHook = myLayout

        -- This hack is necessary to make Java GUIs like NetBeans work.  See the FAQ.
        , logHook = setWMName "LG3D"
        }
