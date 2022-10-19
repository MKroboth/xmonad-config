module MyConfig.GeneralConfig(myWorkspaces) where

myWorkspaces :: [String]
myWorkspaces = [show x | x <- [1 .. 9]]
