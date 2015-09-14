import           Biblio
import           Site
import qualified Data.Text.IO as TIO
import           Control.Monad ((>=>))

main :: IO ()
main = do
  makeBib bibT bibF pubsF
  catFiles [pResF, pubsF] bResF
  makeSite tops
