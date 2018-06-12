module Views.Home exposing (view)

import Html exposing (Html, div, h1, h2, text)
import Html.Attributes exposing (class, src, target, href)
import Models exposing (Model)


view : Model -> Html msg
view model =
  div [ class "above-the-fold" ]
    [ h1 [] [ text "Ben Allred" ]
    , h2 [] [ text "Full Stack Web Developer"] ]
