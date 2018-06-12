module Views.Utils exposing (..)

import RemoteData exposing(WebData, RemoteData(..))


webDataToList : WebData a -> (a -> List b) -> List b
webDataToList headerData f =
  case headerData of
    Success data ->
      f data
    _ ->
      []
