-- |

module MyConfig.Keybindings(keyConfig) where

import XMonad(X, spawn)



keyConfig :: [(String, X ())]
keyConfig = [ "M-x e" $> spawn "emacs"
            , "M-x w" $> spawn "qutebrowser"
            ]


-- DSL for keyConfig

($>) :: String -> X () -> (String, X ())
x $> y = (x, y)
