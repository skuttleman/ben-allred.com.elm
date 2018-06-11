module Main exposing (..)

import Commands exposing (..)
import Html exposing (Html, li, span, text, ul, div, img, main_, h1, h2, header, nav, i, a)
import Html.Attributes exposing (class, src, target, href)
import Models exposing (..)
import Msgs exposing (Msg(..))
import Navigation
import RemoteData exposing (WebData)

bgImage : Model -> String
bgImage model =
  case Maybe.map .bgImage model.page of
      Just (Just bgImage) ->
          bgImage
      _ -> ""



linkItem : LinkData -> Html msg
linkItem link =
  li [class "link-element"]
    [ a [target "_blank", href link.link]
      [i [class link.iClass] [] ]]

navItem : Route -> NavData -> Html msg
navItem route nav =
  let
    active = route == (pathToRoute nav.link)
  in
    li [class ("nav-element" ++ (if active then " current" else ""))]
      [a [href nav.link]
        [ i [class ("nav-icon " ++ nav.iClass)] []
        , span [class "nav-text"] [text nav.text]]]

webDataToList : WebData HeaderData -> (HeaderData -> List a) -> List a
webDataToList headerData f =
  case headerData of
      RemoteData.Success data ->
        f data
      _ ->
        []


view : Model -> Html msg
view model =
  div []
    [ div [ class "image-container" ]
      [ img [ class "bg-image", src (bgImage model) ] [] ]
    , header []
      [ nav [class "top-bar nav"]
        [ ul [class "links"] (List.map linkItem (webDataToList model.header .links))
        , ul [class "navs"] (List.map (navItem model.route) (webDataToList model.header .navs))]]
    , main_ [ class "app" ]
      [ div [ class "above-the-fold" ]
        [ h1 [] [ text "Ben Allred" ]
        , h2 [] [ text "Full Stack Web Developer"] ] ] ]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
      OnLocationChange -> ( model, Cmd.none )
      OnFetchHeader header -> 
        ( { model | header = header, page = routeToPage model.route header }, Cmd.none )


routeToPath : Route -> String
routeToPath route =
  case route of
    Bio -> "/bio"
    Portfolio -> "/portfolio"
    Music -> "/music"
    Home -> "/"
    _ -> "/notfound"


pathToRoute : String -> Route
pathToRoute path =
  case path of
    "/bio" -> Bio
    "/portfolio" -> Portfolio
    "/music" -> Music
    "/" -> Home
    _ -> NotFound




routeToPage : Route -> (WebData HeaderData) -> Maybe NavData
routeToPage route headerData =
  let
    path = routeToPath route  
  in
    case headerData of
      RemoteData.Success data ->
        data.navs
          |> List.filter (\nav -> nav.link == path)
          |> List.head
      _ ->
        Nothing
          

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

init : Navigation.Location -> ( Model, Cmd Msg )
init _ =
  ( { route = Home
    , header =
      RemoteData.Loading
    , page = Nothing }
  , fetchHeader )
