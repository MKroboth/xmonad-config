-- |

module MyConfig.Hooks.LayoutHook(myLayoutHook) where

import XMonad (layoutHook, def)
import XMonad.Hooks.ManageDocks(avoidStruts)

myLayouts = layoutHook def

myLayoutHook = avoidStruts $ myLayouts
