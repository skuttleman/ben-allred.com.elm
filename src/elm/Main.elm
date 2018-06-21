module Main exposing (..)

import Commands exposing (..)
import Models exposing (..)
import Msgs exposing (Msg(..))
import Navigation
import RemoteData exposing (WebData)
import Update exposing (..)
import Views.Main as Views


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Navigation.program OnLocationChanged
        { init = init
        , view = Views.view
        , update = update
        , subscriptions = subscriptions }


init : Nav location -> ( Model, Cmd Msg )
init { pathname } =
  ( { route = pathToRoute pathname
    , header = RemoteData.Loading
    , bio = RemoteData.Loading
    , apps = RemoteData.Loading
    , songs = RemoteData.Loading
    , albums = RemoteData.Loading
    , music = { visible = False, playing = False, expanded = False, song = Nothing, album = Nothing }
    , page = Nothing }
  , Cmd.batch [ fetchHeader, fetchBio, fetchApps, fetchSongs, fetchAlbums ] )
