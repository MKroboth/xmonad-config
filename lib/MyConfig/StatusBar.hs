{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}


module MyConfig.StatusBar(withMyStatusBar) where

import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Util.WorkspaceCompare(getSortByXineramaRule)

-- Status bar config


printCurrentWorkspace = dzenColor "white" "#2b4f98" . pad
printVisibleWorkspace = dzenColor "black" "#999999" . pad
printHiddenWorkspace = dzenColor "black" "#cccccc" . pad
printHiddenWorkspaceNoWindows = const ""
printUrgentWorkspace = dzenColor "red" "yellow" . pad
workspaceSeperator = ""
seperator = ""
printLayout = dzenColor "black" "#cccccc" . pad

dzenArgs = ["-ta l", "-dock"]

--------------------------------------------------

dzenBinary = "/usr/bin/dzen2"
xmonadpropreadBinary = "~/bin/xmonadpropread.hs"

xmonadPropReadInto = ((xmonadpropreadBinary ++ " | ")++)

dzenCommand = dzenBinary ++ " " ++ (unwords dzenArgs)


dzenConfig :: PP
dzenConfig = def { ppCurrent = printCurrentWorkspace
                    , ppVisible = printVisibleWorkspace
                    , ppHidden = printHiddenWorkspace
                    , ppHiddenNoWindows = printHiddenWorkspaceNoWindows
                    , ppUrgent = printUrgentWorkspace
                    , ppWsSep = workspaceSeperator
                    , ppSep = seperator
                    , ppLayout = printLayout
                    , ppSort    = getSortByXineramaRule
                    , ppTitle = ("^bg(#324c80)" ++) . dzenEscape . pad
                    }


myStatusBar = statusBarProp (xmonadPropReadInto dzenCommand) (pure dzenConfig)
withMyStatusBar x = withSB myStatusBar x
