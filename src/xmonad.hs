import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Actions.SpawnOn

  
main :: IO ()
  
main = do
  mainBar <- spawnMainBar
  spawnXMonad mainBar


spawnMainBar = spawnPipe $ "dzen2 -fn Hasklig:size=12 -p -h 27 -w " ++ (show $ screenWidth /2) ++ " -xs 1 -ta l -e 'onstart=lower'"
  where screenWidth = 1920
  
  
spawnXMonad mainBar = xmonad $ docks $ def
        { modMask = mod4Mask
        , terminal = "/usr/bin/terminology"
        , startupHook = myStartupHook
        , manageHook = manageDocks <+> manageHook def
        , layoutHook = avoidStruts $ layoutHook def
        , logHook = myLogHook mainBar
        } `additionalKeysP` myAdditionalKeys


myStartupHook :: X ()
myStartupHook = do spawnOnce "source $HOME/.profile"
                   spawnOn "9" "thunderbird"

myAdditionalKeys =
  [ ("M-x e", safeSpawn "emacs" [])
  , ("M-x w", safeSpawn "vivaldi-stable" [])
  ]


myLogHook mainBar = dynamicLogWithPP def
  { ppOutput          = hPutStrLn mainBar
  , ppCurrent         = dzenColor "#303030" "#909090" . pad
  , ppVisible         = pad
  , ppHidden          = dzenColor "#909090" "" . pad 
  , ppHiddenNoWindows = dzenColor "#606060" "" . pad
  , ppLayout          = dzenColor "#909090" "" . pad
  , ppUrgent          = dzenColor "#ff0000" "" . pad . dzenStrip
  , ppTitle           = shorten 100
  , ppWsSep           = ""
  , ppSep             = "  "
  }
