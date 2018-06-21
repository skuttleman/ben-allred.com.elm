module Views.Components exposing (..)

import Html exposing(Html, a, span, text)
import Html.Attributes exposing (target)
import Html.Events exposing (onWithOptions)
import Json.Decode as Decode
import Msgs exposing(..)


blank : List (Html.Attribute msg) -> List (Html msg) -> Html msg
blank attributes children =
  a (target "_blank" :: attributes) children


spa : String -> List (Html Msg) -> Html Msg
spa href children =
  a [ preventDefault href ] children


preventDefault : String -> Html.Attribute Msg
preventDefault href =
  onWithOptions
    "click"
    { stopPropagation = True, preventDefault = True }
    <| Decode.succeed <| ChangeLocation href


navLink : Bool -> Bool -> String -> List (Html.Attribute Msg) -> List (Html Msg) -> Html Msg
navLink active resume href attributes =
  if active then
    span attributes
  else if resume then
    blank attributes
  else
    spa href


txt : (List (Html.Attribute Msg) -> List (Html Msg) -> Html Msg) -> String -> Html Msg
txt tag string =
  tag [] [ text string ]
