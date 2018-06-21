module Views.Header exposing(view)

import Html exposing (Html, ul, li, a, i, nav, span, text)
import Html.Attributes exposing (class, src, target, href)
import Models exposing (..)
import Msgs exposing (..)
import Views.Utils exposing (..)
import Views.Components exposing (..)


view : Model -> Html Msg
view { route, header } =
  nav [class "top-bar nav"]
    [ ul [class "links"] <|
      List.map linkItem <| webDataToList header .links
    , ul [class "navs"] <|
      List.map (navItem route) <| webDataToList header .navs ]


linkItem : LinkData -> Html msg
linkItem { link, iClass } =
  li [ class "link-element" ]
    [ blank [ href link ]
      [ i [ class iClass ] [] ] ]


navItem : Route -> NavData -> Html Msg
navItem route ({ link, iClass } as nav) =
  let
    active = route == pathToRoute link
    resume = nav.text == "resume"
    navClass = if active then " current" else ""
  in
    li [ class <| "nav-element" ++ navClass ]
      [ navLink active resume link [ href link ]
        [ i [ class <| "nav-icon " ++ iClass ] []
        , span [ class "nav-text" ] [ text nav.text ] ] ]
