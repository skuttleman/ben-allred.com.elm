module ModelsTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (string)
import Models
import RemoteData exposing (WebData)
import Test exposing (..)


linkToNavData : String -> Models.NavData
linkToNavData link =
  { link = link, iClass = "iClass", text = "text", bgImage = Nothing }


routeToPathTest : Test
routeToPathTest =
  describe "Models Test"
    [ describe ".routeToPath"
      [ test "translates Bio" <|
        always <|
          Expect.equal
            (Models.routeToPath Models.Bio)
            "/bio"

      , test "translates Portfolio" <|
        always <|
          Expect.equal
            (Models.routeToPath Models.Portfolio)
            "/portfolio"

      , test "translates Music" <|
        always <|
          Expect.equal
            (Models.routeToPath Models.Music)
            "/music"

      , test "translates Home" <|
        always <|
          Expect.equal
            (Models.routeToPath Models.Home)
            "/"

      , test "translates NotFound" <|
        always <|
          Expect.equal
            (Models.routeToPath Models.NotFound)
            "/notfound" ]

    , describe ".pathToRoute"
      [ test "translates /bio" <|
        always <|
          Expect.equal
            (Models.pathToRoute "/bio")
            Models.Bio

      , test "translates /portfolio" <|
        always <|
          Expect.equal
            (Models.pathToRoute "/portfolio")
            Models.Portfolio

      , test "translates /music" <|
        always <|
          Expect.equal
            (Models.pathToRoute "/music")
            Models.Music

      , test "translates /" <|
        always <|
          Expect.equal
            (Models.pathToRoute "/")
            Models.Home

      , fuzz string "translates any other path as NotFound" <|
        Models.pathToRoute >>
          Expect.equal Models.NotFound ]
    
    , describe ".routeToPage" <|
      let
        navs = List.map linkToNavData [ "/bio", "/portfolio", "/music", "/" ]
        headerData = RemoteData.Success { links = [], navs = navs }
      in
        [ test "Matches on Bio" <|
          always <|
            Expect.equal
              (Models.routeToPage Models.Bio headerData)
              (Just <| linkToNavData "/bio")

        , test "Matches on Portfolio" <|
          always <|
            Expect.equal
              (Models.routeToPage Models.Portfolio headerData)
              (Just <| linkToNavData "/portfolio")

        , test "Matches on Music" <|
          always <|
            Expect.equal
              (Models.routeToPage Models.Music headerData)
              (Just <| linkToNavData "/music")

        , test "Matches on Home" <|
          always <|
            Expect.equal
              (Models.routeToPage Models.Home headerData)
              (Just <| linkToNavData "/")

        , test "Matches on NotFound" <|
          always <|
            Expect.equal
              (Models.routeToPage Models.NotFound headerData)
              Nothing ] ]
