module Msgs exposing (Msg(..))

import Models exposing (..)
import RemoteData exposing (WebData)


type Msg =
  OnLocationChange
  | OnFetchHeader (WebData HeaderData)
