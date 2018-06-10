module Main exposing (..)

import Html exposing (Html, li, text, ul, div, img, main_, h1, h2)
import Html.Attributes exposing (class, src)
import Navigation

type Route =
  Home

type Msg =
  OnLocationChange

type alias Model =
  { route : Route
  , backgroundImage : String 
  }

init : Navigation.Location -> ( Model, Cmd Msg )
init _ =
  ( { route = Home
    , backgroundImage = "/static/images/snow.jpg"}
  , Cmd.none )

view : Model -> Html msg
view model =
  div []
    [ div [ class "image-container" ]
      [ img [ class "bg-image", src model.backgroundImage ] [] ]
    , main_ [ class "app" ]
      [ div [ class "above-the-fold" ]
        [ h1 [] [ text "Ben Allred" ]
        , h2 [] [ text "Full Stack Web Developer"] ] ] ]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
      OnLocationChange -> ( model, Cmd.none )
 

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

main : Program Never Model Msg
main =
    Navigation.program (\a -> OnLocationChange)
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
