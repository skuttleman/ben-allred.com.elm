module Views.Portfolio exposing (view)

import Html exposing (Html, div, h1, h2, h3, h4, li, p, ul, text)
import Html.Attributes exposing (class, href)
import Models exposing (..)
import Msgs exposing (Msg)
import Views.Utils exposing (..)
import Views.Components exposing (..)

view : Model -> Html Msg
view { apps } =
  div []
    [ div [ class "above-the-fold" ]
      [ txt h1 "Portfolio" ]
    , div [ class "below-the-fold" ]
      [ txt h2 "My Projects"
      , ul [ class "projects" ]
        (List.map project (webDataToList apps .apps)) ] ]


project : AppItem -> Html Msg
project { link, title, tagLine, description, technologies, repos } =
  li [ class "project" ]
    [ h3 []
      [ blank [ class "project title", href link ]
        [ text title ] ]
    , txt h4 tagLine
    , txt p description
    , ul [ class "technologies" ] ((txt li "Technologies: ")::(List.map (txt li) technologies))
    , ul [ class "repos" ] (List.map repository repos) ]


repository : Repo -> Html Msg
repository { link, name } =
  li [ class "repo" ]
    [ blank [ href ("https://github.com/skuttleman" ++ link) ] [ text name ] ]
