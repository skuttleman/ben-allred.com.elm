module Views.Main exposing (..)

import Models exposing (Model, Route(..))
import Html exposing (Html, audio, div, img, header, main_, text)
import Html.Attributes exposing (class, src, target, href, id, style)
import Html.Events exposing (on)
import Json.Decode as Json
import Msgs exposing (..)
import Views.Bio as BioView
import Views.Header as Header
import Views.Home as Home
import Views.Music as Music
import Views.Player as Player
import Views.Portfolio as PortfolioView
import Views.Utils exposing (classIf)


bgImage : Model -> String
bgImage model =
  case Maybe.map .bgImage model.page of
      Just (Just bgImage) ->
          bgImage
      _ -> ""


pageTitle : Model -> String
pageTitle model =
  case Maybe.map .text model.page of
    Just title ->
      title
    _ -> ""


rootView : (Model -> Html Msg) -> Model -> Html Msg
rootView component model =
  div []
    [ div [ class "image-container" ]
      [ img [ class "bg-image", src <| bgImage model ] [] ]
    , header [] [ Header.view model]
    , main_
      [ id "scroll", classIf [ ( pageTitle model, True ), ( "bottom-margin", model.music.visible ) ] "app" ]
      [ component model ]
    , Player.view model
    , audio
      [ id "audio-player"
      , style [ ( "display", "none" ) ]
      , on "ended" <| Json.succeed OnSongEnded ] [] ]


routeToComponent : Route -> Model -> Html Msg
routeToComponent route =
  case route of
    Bio -> BioView.view
    Portfolio -> PortfolioView.view
    Music -> Music.view
    _ -> Home.view


view : Model -> Html Msg
view model =
  rootView (routeToComponent model.route) model
