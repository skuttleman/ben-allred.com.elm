module Main exposing (..)

import Commands exposing (..)
import Models exposing (..)
import Msgs exposing (Msg(..))
import Navigation
import RemoteData exposing (WebData)
import Views.Main as Views


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
      OnLocationChanged location ->
        ( { model | route = pathToRoute location.pathname, page = (routeToPage (pathToRoute location.pathname) model.header) }, Cmd.none )
      OnHeaderReceived header -> 
        ( { model | header = header, page = routeToPage model.route header }, Cmd.none )
      OnBioReceived bio ->
        ( { model | bio = bio }, Cmd.none )
      OnAppsReceived apps ->
        ( { model | apps = apps }, Cmd.none )
      ChangeLocation path ->
        ( model , Navigation.newUrl path )
      _ ->
        ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Navigation.program OnLocationChanged
        { init = init
        , view = Views.view
        , update = update
        , subscriptions = subscriptions
        }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
  ( { route = pathToRoute location.pathname
    , header = RemoteData.Loading
    , bio = RemoteData.Loading
    , apps = RemoteData.Loading
    , page = Nothing }
  , Cmd.batch [ fetchHeader, fetchBio, fetchApps ] )
