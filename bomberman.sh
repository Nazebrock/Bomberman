#!/bin/sh

function interfaces {
    echo "INTERFACES"
    ocamlc gtypes.mli ig.mli reseau.mli
}

function client {
    echo "CLIENT"
    ocamlc -o client unix.cma graphics.cma ig.ml reseau.ml client.ml
}

function serveur {
    echo "SERVEUR"
    ocamlc -o serveur unix.cma str.cma graphics.cma ig.ml player.ml bombermap.ml bombe.ml reseau.ml serveur.ml
}

case "$1" in
    compile)
        case "$2" in
            client)
                interfaces
                client
                exit 0
            ;;
            serv | serveur)
                interfaces
                serveur
                exit 0
            ;;
            *)
                interfaces
                client
                serveur
                exit 0
            ;;
        esac
    ;;
    run)
        ./serveur -map map/map3 &
        sleep 1
        ./client &
        ./client &
        ./client &
    ;;
    *)
        ./serveur &
        sleep 1
        ./client
    ;;
esac
