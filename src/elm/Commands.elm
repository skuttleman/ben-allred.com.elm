module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (..)
import Models exposing (..)
import RemoteData

fetch : String -> Decode.Decoder t -> (RemoteData.WebData t -> Msg) -> Cmd Msg
fetch url decoder msg =
  Http.get url decoder
        |> RemoteData.sendRequest
        |> Cmd.map msg


fetchHeader : Cmd Msg
fetchHeader =
  fetch "/static/json/header.json" headerDecoder OnHeaderReceived


fetchBio : Cmd Msg
fetchBio =
  fetch "/static/json/bios.json" bioDecoder OnBioReceived


fetchApps : Cmd Msg
fetchApps =
  fetch "/static/json/apps.json" appsDecoder OnAppsReceived


headerDecoder : Decode.Decoder HeaderData
headerDecoder =
  decode HeaderData
    |> required "navs" (Decode.list navDecoder)
    |> required "links" (Decode.list linkDecoder)


navDecoder : Decode.Decoder NavData
navDecoder =
  decode NavData
    |> required "link" Decode.string
    |> required "iClass" Decode.string
    |> required "text" Decode.string
    |> required "bgImage" (Decode.maybe Decode.string)


linkDecoder : Decode.Decoder LinkData
linkDecoder =
  decode LinkData
    |> required "link" Decode.string
    |> required "iClass" Decode.string


bioDecoder : Decode.Decoder BioData
bioDecoder =
  decode BioData
    |> required "bios" (Decode.list bioItemDecoder)


bioItemDecoder : Decode.Decoder BioItem
bioItemDecoder =
  decode BioItem
    |> required "header" Decode.string
    |> required "paragraphs" (Decode.list Decode.string)


appsDecoder : Decode.Decoder AppData
appsDecoder =
  decode AppData
    |> required "apps" (Decode.list appItemDecoder)


appItemDecoder : Decode.Decoder AppItem
appItemDecoder =
  decode AppItem
    |> required "id" Decode.int
    |> required "title" Decode.string
    |> required "repos" (Decode.list repoDecoder)
    |> required "link" Decode.string
    |> required "tagLine" Decode.string
    |> required "description" Decode.string
    |> required "technologies" (Decode.list Decode.string)


repoDecoder : Decode.Decoder Repo
repoDecoder =
  decode Repo
    |> required "name" Decode.string
    |> required "link" Decode.string
