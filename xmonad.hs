-- -*- mode: haskell; coding: utf-8 -*-

{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}

import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Util.WorkspaceCompare(getSortByXineramaRule)
import XMonad.Util.EZConfig(additionalKeysP)
import MyConfig.GeneralConfig
import MyConfig.Keybindings
import qualified MyConfig.Applications as Apps
import MyConfig.Hooks.StartupHook
import MyConfig.Hooks.LayoutHook
import MyConfig.Hooks.ManageHook




-- Status Bars

workspaceBarFlags :: String
workspaceBarFlags = "-ta l -dock"

dzenConfig :: PP
dzenConfig = dzenPP { ppCurrent = dzenColor "red" "#efebe7"
                    , ppVisible = wrap "[" "]"
                    , ppSort    = getSortByXineramaRule
                    }

-- XMonad main

main :: IO ()
main = xmonadCmd $ def { modMask = mod4Mask
                     , terminal = Apps.myTerminal
                     , workspaces = myWorkspaces
                     , layoutHook = myLayoutHook
                     , startupHook = myStartupHook
                     , manageHook = myManageHook
                     , logHook = dynamicLogWithPP dzenConfig
                     } `additionalKeysP` keyConfig
  where xmonadCmd x = xmonad . docks =<< dzenWithFlags workspaceBarFlags x
