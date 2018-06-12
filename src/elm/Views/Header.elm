module Views.Header exposing(view)

import Html exposing (Html, ul, li, a, i, nav, span, text)
import Html.Attributes exposing (class, src, target, href)
import Models exposing (..)
import Msgs exposing (..)
import Views.Utils exposing (..)
import Views.Components exposing (..)


view : Model -> Html Msg
view model =
  nav [class "top-bar nav"]
    [ ul [class "links"]
      (List.map linkItem (webDataToList model.header .links))
    , ul [class "navs"]
      (List.map (navItem model.route) (webDataToList model.header .navs)) ]

linkItem : LinkData -> Html msg
linkItem link =
  li [class "link-element"]
    [ blank [href link.link]
      [i [class link.iClass] [] ]]


navItem : Route -> NavData -> Html Msg
navItem route nav =
  let
    active = route == (pathToRoute nav.link)
    resume = nav.text == "resume"
  in
    li [ class ("nav-element" ++ (if active then " current" else "")) ]
      [ navLink active resume nav.link [ href nav.link ]
        [ i [ class ("nav-icon " ++ nav.iClass) ] []
        , span [ class "nav-text" ] [ text nav.text ] ] ]
