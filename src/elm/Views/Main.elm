module Views.Main exposing (..)

import Models exposing (Model, Route(..))
import Html exposing (Html, div, img, header, main_, text)
import Html.Attributes exposing (class, src, target, href)
import Msgs exposing (Msg)
import Views.Bio as BioView
import Views.Header as Header
import Views.Home as Home
import Views.Portfolio as PortfolioView


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
      [ img [ class "bg-image", src (bgImage model) ] [] ]
    , header [] [ Header.view model]
    , main_ [ class ("app " ++ (pageTitle model)) ] [ component model ] ]


routeToComponent : Route -> Model -> Html Msg
routeToComponent route =
  case route of
    Bio -> BioView.view
    Portfolio -> PortfolioView.view
    _ -> Home.view


view : Model -> Html Msg
view model =
  rootView (routeToComponent model.route) model




bioView : Model -> Html Msg
bioView model =
  div [] [text "something stupid"]
