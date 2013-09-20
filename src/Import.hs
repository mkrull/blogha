module Import where

import Yesod.Default.Util
import Data.Default
import Language.Haskell.TH

widgetFile :: FilePath -> ExpQ
widgetFile = widgetFileReload def