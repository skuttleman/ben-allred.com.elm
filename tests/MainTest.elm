module MainTest exposing (..)

import Commands exposing (..)
import Expect exposing (Expectation)
import Main
import Test exposing (..)


suite : Test
suite =
  describe "Main test"
    [ describe ".init"
      [ test "fetches necessary data" <|
        always <|
          let
            ( _, actual ) = Main.init { pathname = "somepath" }
            expected = Cmd.batch [ fetchHeader, fetchBio, fetchApps, fetchSongs, fetchAlbums ]
          in
            Expect.equal actual expected ] ]
