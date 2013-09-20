module Import where

import Yesod.Default.Util (widgetFileReload)
import Language.Haskell.TH (ExpQ)
import Network.HTTP.Conduit (Manager, newManager, def)

widgetFile :: FilePath -> ExpQ
widgetFile = widgetFileReload def