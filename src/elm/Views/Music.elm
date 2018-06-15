module Views.Music exposing (view)

import Html exposing (Html, div, span, h1, h2, i, p, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Models exposing (..)
import Msgs exposing (..)
import Views.Components exposing (txt)


view : Model -> Html Msg
view model =
  div []
    [ div [ class "above-the-fold" ]
      [ txt h1 "Music" ]
    , div [ class "below-the-fold" ]
      [ txt h2 "My Music"
      , if model.music.visible
          then span [] []
          else openButton
      , txt p "I have written many songs."
      , txt p "Some of those songs have been recorded."
      , txt p "Some of those recordings are on the internet."
      , txt p "Some of those internets are available here." ] ]


openButton : Html Msg
openButton =
  div
    [ class "open-music-player button"
    , onClick OpenMusicPlayer ]
    [ text "Open Music Player"
    , i [ class "fa fa-external-link" ] [] ]
