module Msgs exposing (..)

import Http
import Models exposing (Player, PlayerId)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnFetchPlayers (WebData (List Player))
    | OnLocationChange Location
    | ChangeLevel Player Int
    | ChangeName Player String
    | OnPlayerSave (Result Http.Error Player)
    | RemovePlayer PlayerId
    | OnPlayerDelete (Result Http.Error PlayerId)
