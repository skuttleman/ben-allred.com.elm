module Views.Main exposing (..)

import Models exposing (Model, Route(..))
import Html exposing (Html, div, img, header, main_, text)
import Html.Attributes exposing (class, src, target, href)
import Msgs exposing (Msg)
import Views.Bio as BioView
import Views.Header as Header
import Views.Home as Home


bgImage : Model -> String
bgImage model =
  case Maybe.map .bgImage model.page of
      Just (Just bgImage) ->
          bgImage
      _ -> ""


rootView : (Model -> Html Msg) -> Model -> Html Msg
rootView component model =
  div []
    [ div [ class "image-container" ]
      [ img [ class "bg-image", src (bgImage model) ] [] ]
    , header [] [ Header.view model]
    , main_ [ class "app" ] [ component model ] ]


routeToComponent : Route -> Model -> Html Msg
routeToComponent route =
  case route of
    Bio -> BioView.view
    _ -> Home.view


view : Model -> Html Msg
view model =
  rootView (routeToComponent model.route) model




bioView : Model -> Html Msg
bioView model =
  div [] [text "something stupid"]
