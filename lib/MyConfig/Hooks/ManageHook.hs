-- |

module MyConfig.Hooks.ManageHook(myManageHook) where

import XMonad(ManageHook, (<+>), manageHook, def)
import XMonad.Hooks.ManageDocks(manageDocks)

myManageHook :: ManageHook
myManageHook = manageDocks <+> manageHook def
