-- |
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}


module MyConfig.StatusBar(withMyStatusBar) where

import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Util.WorkspaceCompare(getSortByXineramaRule)

xmonadPropReadInto = ("~/bin/xmonadpropread.hs | "++)

dzenCommand = "/usr/bin/dzen2 " ++ dzenArgs
dzenArgs = "-ta l -dock"


dzenConfig :: PP
dzenConfig = dzenPP { ppCurrent = dzenColor "red" "#efebe7"
                    , ppVisible = wrap "[" "]"
                    , ppSort    = getSortByXineramaRule
                    }


myStatusBar = statusBarProp (xmonadPropReadInto dzenCommand) (pure dzenConfig)
withMyStatusBar x = withSB myStatusBar x
