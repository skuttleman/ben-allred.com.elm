module Msgs exposing (Msg(..))

import Navigation
import Models exposing (..)
import RemoteData exposing (WebData)


type Msg =
  NoOp
  | OnLocationChanged (Nav Navigation.Location)
  | OnHeaderReceived (WebData HeaderData)
  | OnBioReceived (WebData BioData)
  | OnAppsReceived (WebData AppData)
  | OnSongsReceived (WebData SongData)
  | OnAlbumsReceived (WebData AlbumData)
  | ChangeLocation String
  | OpenMusicPlayer
  | CloseMusicPlayer
  | SelectSong Song Album
  | OnSongEnded
  | TogglePlayerExpanded
  | TogglePlayerPlaying
