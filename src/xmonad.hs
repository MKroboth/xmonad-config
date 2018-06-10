import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Actions.SpawnOn
import XMonad.Actions.PhysicalScreens

import System.IO(Handle)
import Text.Printf

main :: IO ()
  
main = do
  mainBar <- spawnMainBar
  spawnXMonad mainBar

spawnMainBar :: IO Handle
spawnMainBar = spawnPipe $ printf commandFormat font width height
  where commandFormat = "dzen2 -fn %s -p -w %d -h %d -xs 1 -ta l -e 'onstart=lower'"
        font = "Hasklig:size=12"
        screenWidth = 1920 :: Int
        width = screenWidth `div` 2
        height = 27 :: Int

spawnXMonad :: Handle -> IO ()
spawnXMonad mainBar = xmonad $ docks $ def
        { modMask = mod4Mask
        , terminal = "/usr/bin/terminology"
        , startupHook = myStartupHook
        , manageHook = manageDocks <+> manageHook def
        , layoutHook = avoidStruts $ layoutHook def
        , logHook = myLogHook mainBar
        } `additionalKeysP` myAdditionalKeys `removeKeysP` [ "M-S-q" ]


myStartupHook :: X ()
myStartupHook = do spawnOnce "source $HOME/.profile"
                   spawnOn "9" "thunderbird"

myAdditionalKeys :: [(String, X())]
myAdditionalKeys =
  [ ("M-x e", safeSpawn "emacs" [])
  , ("M-x w", safeSpawn "vivaldi-stable" [])
  , ("M-x i", safeSpawn "bash" ["-c", "/usr/bin/intellij-idea-ultimate-edition"]) -- Execute intellij-idea in bash to prevent the SIGINT bug.
  ] ++ workspaceKeys
  where workspaceKeys =
          [ (mask ++ "M-" ++ [key], (action scr))
          | (key, scr)  <- zip "wer" [0..]
          , (action, mask) <- actions
          ]
        actions :: [(PhysicalScreen -> X(), String)]
        actions =
          [ (viewScreen def, "")
          , (sendToScreen def, "S-")
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
