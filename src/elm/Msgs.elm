module Msgs exposing (Msg(..))

import Models exposing (..)
import Navigation
import RemoteData exposing (WebData)


type Msg =
  NoOp
  | OnLocationChanged Navigation.Location
  | OnHeaderReceived (WebData HeaderData)
  | OnBioReceived (WebData BioData)
  | ChangeLocation String
