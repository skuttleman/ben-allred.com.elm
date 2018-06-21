port module Update exposing (..)

import Dom.Scroll as Scroll
import Models exposing (..)
import Msgs exposing (..)
import Navigation
import Task


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
        | song = Just ( song, album )
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
      OnLocationChanged { pathname } ->
        ( { model
          | route = pathToRoute pathname
          , page = routeToPage (pathToRoute pathname) model.header }
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
        ( model , Cmd.batch [ Task.attempt (\_ -> NoOp) <| Scroll.toTop "scroll", Navigation.newUrl path ] )
      _ ->
        ( model, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  let
    ( main, cmd1 ) = updateMain msg model
    ( music, cmd2 ) = updateMusic msg model.music
  in
    ( { main | music = music }, Cmd.batch [ cmd1, cmd2 ] )
