module Views.Player exposing (..)

import Html exposing (Html, a, div, span, ul, li, i, img, text)
import Html.Attributes exposing (class, target, href, src, alt)
import Html.Events exposing (onClick)
import Models exposing (..)
import Msgs exposing (..)
import Views.Utils exposing (..)
import Views.Components exposing (..)


view : Model -> Html Msg
view { music, songs, albums } =
  let
    songList = webDataToList songs .songs
    albumList = webDataToList albums .albums
    { expanded, selected } = music
    selectedSongId =
      case selected of
        Just ( song, _ ) -> song.id
        Nothing -> -1
  in
    case music.visible of
      False ->
        span [] []
      _ ->
        div [ class "music-player" ]
          [ div [ classIf [ ( "expanded", expanded ), ( "collapsed", not expanded ) ] "song-list" ]
            [ ul [ class "songs" ] <| List.map (song selectedSongId albumList) songList ]
          , div [ class "controls" ]
            [ div [ class "now-playing", onClick TogglePlayerExpanded ]
              [ truncateTitle selected
              , i [ classIf [ ( "fa-caret-down", expanded ), ( "fa-caret-up", not expanded ) ] "fa caret" ] [] ]
            , when selected music buttonContainer
            , when selected music albumLink
            , when selected music itunesLink
            , div [ class "button-container" ]
              [ div [ class "button close", onClick CloseMusicPlayer ]
                [ i [ class "fa fa-times" ] [] ] ] ] ]


truncateTitle : Maybe ( Song, Album ) -> Html Msg
truncateTitle selected =
  div [ class "song-title" ]
    [ text <|
      case selected of
        Just ( song, _ ) -> song.title
        Nothing -> "Select a Song" ]


buttonContainer : Album -> Song -> MusicModel -> Html Msg
buttonContainer album song { playing } =
  div [ class "button-container" ]
    [ div [ class "button play-pause", onClick TogglePlayerPlaying ]
      [ i [ classIf [ ( "fa-play", not playing ), ( "fa-pause", playing ) ] "fa" ] [] ] ]


albumLink : Album -> Song -> MusicModel -> Html Msg
albumLink album song music =
  blank [ href album.itunes ]
    [ img [ class "album-cover", src album.art, alt "album cover"] [] ]


itunesLink : Album -> Song -> MusicModel -> Html Msg
itunesLink album song music =
  blank [ href album.itunes ]
    [ div [ class "button itunes" ]
      [ i [ class "fa fa-apple" ] []
      , txt span "iTunes" ] ]


when : Maybe ( Song, Album ) -> MusicModel -> (Album -> Song -> MusicModel -> Html Msg) -> Html Msg
when selected music component =
  case selected of
      Just ( song, album ) -> component album song music
      _ -> span [] []


song : Int -> List Album -> Song -> Html Msg
song selectedId albums sng =
  let
    classes = [ classIf [ ( "selected", selectedId == sng.id ) ] "song" ]
    attributes =
      case albums |> List.filter (.id >> (==) sng.albumId) |> List.head of
          Just album ->
            (onClick <| SelectSong sng album) :: classes
          Nothing ->
            classes
  in
    li attributes [ text sng.title ]
