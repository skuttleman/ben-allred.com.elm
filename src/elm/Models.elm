module Models exposing (..)

import RemoteData exposing (WebData)


type alias HeaderData =
  { navs : List NavData
  , links : List LinkData }


type alias LinkData =
  { link : String
  , iClass : String }


type alias NavData =
  { link : String
  , iClass : String
  , text : String
  , bgImage : Maybe String }


type alias BioData =
  { bios : List BioItem }


type alias BioItem =
  { header : String
  , paragraphs : List String }


type Route =
  Home
  | Bio
  | Portfolio
  | Music
  | NotFound


type alias Model =
    { route : Route
    , header : WebData HeaderData
    , page : Maybe NavData
    , bio : WebData BioData
    , apps : WebData AppData
    , songs : WebData SongData
    , albums : WebData AlbumData
    , music : MusicModel }


type alias MusicModel =
  { visible : Bool
  , song : Maybe ( Song, Album )
  , playing : Bool
  , expanded : Bool }


type alias AppData =
  { apps : List AppItem }


type alias AppItem =
  { id : Int
  , title : String
  , repos : List Repo
  , link : String
  , tagLine : String
  , description : String
  , technologies : List String }


type alias Repo =
  { name : String
  , link : String}


type alias SongData =
  { songs : List Song }


type alias Song =
  { id : Int
  , title : String
  , src : String
  , albumId : Int }


type alias AlbumData =
  { albums : List Album }


type alias Album =
  { id : Int
  , title : String
  , art : String
  , itunes : String }


type alias Nav a =
  { a | pathname : String }


routeToPath : Route -> String
routeToPath route =
  case route of
    Bio -> "/bio"
    Portfolio -> "/portfolio"
    Music -> "/music"
    Home -> "/"
    _ -> "/notfound"


pathToRoute : String -> Route
pathToRoute path =
  case path of
    "/bio" -> Bio
    "/portfolio" -> Portfolio
    "/music" -> Music
    "/" -> Home
    _ -> NotFound


routeToPage : Route -> (WebData HeaderData) -> Maybe NavData
routeToPage route headerData =
  let
    path = routeToPath route
  in
    case headerData of
      RemoteData.Success data ->
        data.navs
          |> List.filter (\nav -> nav.link == path)
          |> List.head
      _ ->
        Nothing
