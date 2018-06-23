module UpdateTest exposing (..)

import Dom.Scroll as Scroll
import Expect exposing (Expectation)
import Fuzz exposing (string)
import Models exposing (..)
import Msgs exposing (..)
import Navigation
import RemoteData exposing (WebData)
import Task
import Test exposing (..)
import Tuple
import Update


modelFixture : Model
modelFixture =
  { route = Home
  , header = RemoteData.Loading
  , bio = RemoteData.Loading
  , apps = RemoteData.Loading
  , songs = RemoteData.Loading
  , albums = RemoteData.Loading
  , music = musicFixture
  , page = Nothing }


musicFixture : MusicModel
musicFixture =
  { visible = False
  , playing = False
  , expanded = False
  , selected = Nothing }


navDataFixture : NavData
navDataFixture =
  { bgImage = Just "bgImage"
  , iClass = "iClass"
  , link = "/"
  , text = "text" }


songFixture : Song
songFixture =
  { albumId = 0
  , id = 0
  , src = "src"
  , title = "title" }


albumFixture : Album
albumFixture =
  { art = "art"
  , id = 0
  , itunes = "itunes"
  , title = "title" }


bioFixture : BioItem
bioFixture =
  { header = "header"
  , paragraphs = [ "paragraph" ] }


appFixture : AppItem
appFixture =
  { description = "description"
  , id = 0
  , link = "link"
  , tagLine = "tagLine"
  , title = "title"
  , repos = []
  , technologies = [ "technology" ] }


suite : Test
suite =
  describe "Update Test"
    [ describe ".updateMusic"
      [ test "handles OpenMusicPlayer" <|
        always <|
          Expect.true "setting visible to true"
            (musicFixture
              |> Update.updateMusic OpenMusicPlayer
              |> Tuple.first
              |> .visible)

      , test "handles CloseMusicPlayer" <|
        always <|
          Expect.false "setting visible to false"
            ({ musicFixture | visible = True }
              |> Update.updateMusic CloseMusicPlayer
              |> Tuple.first
              |> .visible)

      , describe "when handling SelectSong" <|
        let
          ( model, cmd ) =
            (Update.updateMusic
              (SelectSong songFixture albumFixture)
              { musicFixture | expanded = True })
        in
          [ test "sets .selected" <|
            always <|
              Expect.equal
                model.selected
                <| Just ( songFixture, albumFixture )

          , test "sets .expanded" <|
            always <|
              Expect.false "to False" model.expanded

          , test "sets .playing" <|
            always <|
              Expect.true "to True" model.playing

          , test "plays the song" <|
            always <|
              Expect.equal cmd <| Update.play songFixture.src ]

      , describe "when handling OnSongEnded"
        [ test "sets .playing" <|
          always <|
            Expect.false "to False"
              ({ musicFixture | playing = True }
                |> Update.updateMusic OnSongEnded
                |> Tuple.first
                |> .playing)

        , test "unsets .selected" <|
          always <|
            Expect.equal
              Nothing
              ({ musicFixture | selected = Just ( songFixture, albumFixture ) }
                |> Update.updateMusic OnSongEnded
                |> Tuple.first
                |> .selected) ]

      , describe "when handling TogglePlayerExpanded"
        [ describe "and when .expanded is True"
          [ test "sets .expanded" <|
            always <|
              Expect.false "to False"
                ({ musicFixture | expanded = True }
                  |> Update.updateMusic TogglePlayerExpanded
                  |> Tuple.first
                  |> .expanded) ]
        
        , describe "and when .expanded is False"
          [ test "sets .expanded" <|
            always <|
              Expect.true "to True"
                ({ musicFixture | expanded = False }
                  |> Update.updateMusic TogglePlayerExpanded
                  |> Tuple.first
                  |> .expanded) ] ]

      , describe "when handling TogglePlayerPlaying"
        [ describe "and when .playing is True" <|
          let
            ( model, cmd ) =
              Update.updateMusic TogglePlayerPlaying { musicFixture | playing = True }
          in
            [ test "sets .playing" <|
              always <|
                Expect.false "to False" model.playing

            , test "issues the pause Cmd" <|
              always <|
                Expect.equal cmd <| Update.pause () ]
        
        , describe "and when .playing is False" <|
          let
            ( model, cmd ) =
              Update.updateMusic TogglePlayerPlaying { musicFixture | playing = False }
          in
            [ test "sets .playing" <|
              always <|
                Expect.true "to True" model.playing

            , test "issues the resume Cmd" <|
              always <|
                Expect.equal cmd <| Update.resume () ] ] ]

    , describe ".updateMain"
      [ describe "when handling OnLocationChanged" <|
        let
          ( model, _ ) =
            Update.updateMain
              (OnLocationChanged { pathname = "/" })
              { modelFixture
              | header = RemoteData.Success { navs = [ navDataFixture ], links = [] } }
        in
          [ test "sets .route" <|
            always <|
              Expect.equal model.route Home

          , test "sets .page" <|
            always <|
              Expect.equal model.page (Just navDataFixture) ]

      , describe "when handling OnHeaderReceived" <|
        let
          header = RemoteData.Success { navs = [ navDataFixture ], links = [] }
          ( model, _ ) =
            Update.updateMain
              (OnHeaderReceived header)
              { modelFixture | route = Home }
        in
          [ test "sets .header" <|
            always <|
              Expect.equal model.header header
              
          , test "sets .page" <|
            always <|
              Expect.equal model.page (Just navDataFixture) ]

      , test "handles OnBioReceived" <|
        let
          bio = RemoteData.Success { bios = [ bioFixture ] }
        in
          always <|
            Expect.equal
              bio
              (modelFixture
                |> Update.updateMain (OnBioReceived bio)
                |> Tuple.first
                |> .bio)

      , test "handles OnAppsReceived" <|
        let
          apps = RemoteData.Success { apps = [ appFixture ] }
        in
          always <|
            Expect.equal
              apps
              (modelFixture
                |> Update.updateMain (OnAppsReceived apps)
                |> Tuple.first
                |> .apps)

      , test "handles OnAlbumsReceived" <|
        let
          albums = RemoteData.Success { albums = [ albumFixture ] }
        in
          always <|
            Expect.equal
              albums
              (modelFixture
                |> Update.updateMain (OnAlbumsReceived albums)
                |> Tuple.first
                |> .albums)

      , test "handles OnSongsReceived" <|
        let
          songs = RemoteData.Success { songs = [ songFixture ] }
        in
          always <|
            Expect.equal
              songs
              (modelFixture
                |> Update.updateMain (OnSongsReceived songs)
                |> Tuple.first
                |> .songs) ] ]
