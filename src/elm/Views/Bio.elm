module Views.Bio exposing (..)

import Html exposing (Html, div, h1, h2, p, text)
import Html.Attributes exposing (class)
import Models exposing (Model, BioItem)
import Msgs exposing (Msg)
import Views.Components exposing (..)
import Views.Utils exposing (..)


view : Model -> Html Msg
view { bio } =
  div []
    [ div [ class "above-the-fold" ]
      [ h1 [] [ text "Bio" ] ]
    , div [ class "below-the-fold" ]
      <| List.map section <| webDataToList bio .bios ]


section : BioItem -> Html Msg
section { header, paragraphs } =
  div []
    <| txt h2 header :: List.map (txt p) paragraphs
