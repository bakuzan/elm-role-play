module View exposing (..)

import Html exposing (Html, div, text)
import Models exposing (Model, PlayerId, Player)
import Msgs exposing (Msg)
import Players.Edit
import Players.List
import RemoteData


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.PlayersRoute ->
            Players.List.view model.players

        Models.PlayerRoute id ->
            playerEditPage model id

        Models.PlayerNewRoute ->
            playerEditPage model "0"

        Models.NotFoundRoute ->
            notFoundView


playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model playerId =
    case model.players of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading ..."

        RemoteData.Success players ->
            let
                maybePlayer =
                    players
                        |> List.filter (\player -> player.id == playerId)
                        |> List.head

                dropCount =
                  (List.length players) - 1

                nextId =
                  players
                    |> List.sortBy .id
                    |> List.drop dropCount
                    |> List.map (\p -> p.id)
                    |> List.head
                    |> toString
                    |> String.toInt
                    |> Result.withDefault 0
            in
                case maybePlayer of
                    Just player ->
                        Players.Edit.view player

                    Nothing ->
                        Players.Edit.view (Player (toString (nextId + 1)) "" 0)

        RemoteData.Failure err ->
            text (toString err)


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
