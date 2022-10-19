-- -*- mode: haskell; coding: utf-8 -*-

{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}

-- Import general functionality

import XMonad
import XMonad.Hooks.ManageDocks(docks)
import XMonad.Util.EZConfig(additionalKeysP)

-- Import config modules

import MyConfig.GeneralConfig
import MyConfig.Keybindings
import qualified MyConfig.Applications as Apps
import MyConfig.Hooks.StartupHook
import MyConfig.Hooks.LayoutHook
import MyConfig.Hooks.ManageHook
import MyConfig.StatusBar


-- Execute config

main :: IO ()
main = xmonadCmd $ def { modMask = mod4Mask
                     , terminal = Apps.myTerminal
                     , workspaces = myWorkspaces
                     , layoutHook = myLayoutHook
                     , startupHook = myStartupHook
                     , manageHook = myManageHook
                     } `additionalKeysP` keyConfig
  where xmonadCmd = xmonad . docks . withMyStatusBar
