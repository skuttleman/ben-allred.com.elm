module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (..)
import Models exposing (..)
import RemoteData

fetchHeader : Cmd Msg
fetchHeader =
    Http.get headerUrl headerDecoder
        |> RemoteData.sendRequest
        |> Cmd.map OnFetchHeader


headerUrl : String
headerUrl =
    "/static/json/header.json"


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
