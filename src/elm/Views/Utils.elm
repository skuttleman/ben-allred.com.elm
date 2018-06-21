module Views.Utils exposing (..)

import Html
import Html.Attributes exposing (class)
import RemoteData exposing(WebData, RemoteData(..))


webDataToList : WebData a -> (a -> List b) -> List b
webDataToList headerData f =
  case headerData of
    Success data ->
      f data
    _ ->
      []


classFold : ( String, Bool ) -> String -> String
classFold ( s, b ) str =
  if b then
    str ++ " " ++ s
  else
    str


classIf : List ( String, Bool ) -> String -> Html.Attribute msg
classIf classRules initial =
  classRules
    |> List.foldl classFold initial
    |> String.trim
    |> class
