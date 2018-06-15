port module Update exposing (..)

import Models exposing (..)
import Msgs exposing (..)
import Navigation


port play : String -> Cmd msg
port pause : () -> Cmd msg
port resume : () -> Cmd msg


updateMusic : Msg -> MusicModel -> ( MusicModel, Cmd Msg )
updateMusic msg music =
  case msg of
    OpenMusicPlayer ->
      ( { music | visible = True }, Cmd.none )
    CloseMusicPlayer ->
      ( { music | visible = False }, Cmd.none )
    SelectSong song album ->
      ( { music
        | song = Just song
        , album = Just album
        , playing = True
        , expanded = False }
      , play song.src )
    OnSongEnded ->
      ( { music | playing = False }, Cmd.none )
    TogglePlayerExpanded ->
      ( { music | expanded = not music.expanded }, Cmd.none )
    TogglePlayerPlaying ->
      let
        cmd =
          case music.playing of
            True -> pause
            False -> resume
      in
        ( { music | playing = not music.playing }, cmd () )
    _ ->
      ( music, Cmd.none )


updateMain : Msg -> Model -> ( Model, Cmd Msg )
updateMain msg model =
  case msg of
      OnLocationChanged location ->
        ( { model
          | route = pathToRoute location.pathname
          , page = (routeToPage (pathToRoute location.pathname) model.header) }
        , Cmd.none )
      OnHeaderReceived header ->
        ( { model | header = header, page = routeToPage model.route header }, Cmd.none )
      OnBioReceived bio ->
        ( { model | bio = bio }, Cmd.none )
      OnAppsReceived apps ->
        ( { model | apps = apps }, Cmd.none )
      OnAlbumsReceived albums ->
        ( { model | albums = albums }, Cmd.none )
      OnSongsReceived songs ->
        ( { model | songs = songs }, Cmd.none )
      ChangeLocation path ->
        ( model , Navigation.newUrl path )
      _ ->
        ( model, Cmd.none )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  let
    ( main, cmd1 ) = updateMain msg model
    ( music, cmd2 ) = updateMusic msg model.music
  in
    ( { main | music = music }, Cmd.batch [ cmd1, cmd2 ] )
