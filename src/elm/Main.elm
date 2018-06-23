module Main exposing (..)

import Commands exposing (..)
import Models exposing (..)
import Msgs exposing (Msg(..))
import Navigation
import RemoteData exposing (WebData)
import Update exposing (..)
import Views.Main as Views


subscriptions : a -> Sub msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
  Navigation.program (locationToNav >> OnLocationChanged)
    { init = locationToNav >> init
    , view = Views.view
    , update = update
    , subscriptions = subscriptions }


init : Nav -> ( Model, Cmd Msg)
init { pathname } =
  ( { route = pathToRoute pathname
    , header = RemoteData.Loading
    , bio = RemoteData.Loading
    , apps = RemoteData.Loading
    , songs = RemoteData.Loading
    , albums = RemoteData.Loading
    , music = { visible = False, playing = False, expanded = False, selected = Nothing }
    , page = Nothing }
  , Cmd.batch [ fetchHeader, fetchBio, fetchApps, fetchSongs, fetchAlbums ] )
