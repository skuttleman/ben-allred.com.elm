module Models exposing (..)

import RemoteData exposing (WebData)


type alias HeaderData =
  { navs : List NavData
  , links : List LinkData
  }

type alias LinkData =
  { link : String
  , iClass : String
  }

type alias NavData =
  { link : String
  , iClass : String
  , text : String
  , bgImage : Maybe String
  }

type Route =
  Home
  | Bio
  | Portfolio
  | Music
  | NotFound

type alias Model =
  { route : Route
  , header : (WebData HeaderData)
  , page : Maybe NavData
  }
