open Gtypes;;
open String;;
open Reseau;;

(** Plateau
 *  0 = Sol
 *  1 = Bombe
 *  2 = flamme
 *  10 = Cassable Brise 
 *  11 = Cassable Intact
 *  12 = incassable
 *)
let board = ref [||];;
let width = 92;;
let heigth = 72;;

let initBoard b =
    let nbr_col = Array.length b.(0) in
    let nbr_lig = Array.length b in
    Ig.init width heigth nbr_lig nbr_col;
    for i = 0 to nbr_lig - 1  do
        for j = 0 to nbr_col - 1 do
            if b.(i).(j) = 11 then
                Ig.affiche_sprite (Bloc {blk_i = i; blk_j = j; blk_forme = Cassable Intact})
            else if b.(i).(j) = 12 then
                Ig.affiche_sprite (Bloc {blk_i = i; blk_j = j; blk_forme = Incassable})
        done;
    done;
    Ig.affiche (); 
;;

let gameLoop () =
    let fin = ref false in
    while not !fin do
        try
            Unix.sleepf 0.01;
            if Ig.touche_pressee () then
                envoyer_message_au_serveur (Ig.lecture_touche ());
            let m = recevoir_un_message_du_serveur () in
            List.iter (function
                | Affiche s -> Ig.affiche_sprite s
                | Efface s -> Ig.efface_sprite s
                | Refresh s -> Ig.efface_sprite s; Ig.affiche_sprite s
                | Fin b -> fin := b
            ) m;
            Ig.affiche ();
        with | Aucun_Message -> ();
             | Graphics.Graphic_failure m -> deconnection_du_serveur (); fin := true;
    done;
;;


let connect () =
    connexion_au_serveur "127.0.0.1" 7885;
    board := recevoir_un_message_du_serveur ();
;;

connect ();;
initBoard !board;;
gameLoop () ;;
