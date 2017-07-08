module Update exposing (..)

import Routing exposing (parseLocation)
import Msgs exposing (Msg)
import Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchPlayers response ->
            ( { model | players = response }, Cmd.none )

        Msgs.OnLocationChange location ->
          let
            newRoute =
              parseLocation location
          in
            ( { model | route = newRoute }, Cmd.none )
