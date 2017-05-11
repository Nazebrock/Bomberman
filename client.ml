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

let port = ref 8888;;
let machine = ref "127.0.0.1";;
(** Etablie la duree de recharge d'une bombe*)
let bomb_reload = 70;;

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
    let bomb_timer = ref 0 in
    while not !fin do
        try
            Unix.sleepf 0.01;
            if Ig.touche_pressee () then begin
                let c = Ig.lecture_touche () in
                match c with
                    | 'b' -> if !bomb_timer = 0 then begin
                                bomb_timer := bomb_reload;
                                envoyer_message_au_serveur 'b'
                    end;
                    | _ -> envoyer_message_au_serveur c;
            end;
            let m = recevoir_un_message_du_serveur () in
            List.iter (function
                | Affiche s -> Ig.affiche_sprite s
                | Efface s -> Ig.efface_sprite s
                | Refresh s -> Ig.efface_sprite s; Ig.affiche_sprite s
                | Fin b -> fin := b;
            ) m;
            if !bomb_timer > 0 then
                bomb_timer := !bomb_timer - 1;
            Ig.affiche ();
        with | Aucun_Message -> ();
             | Graphics.Graphic_failure m -> deconnection_du_serveur (); fin := true;
    done;
;;


let connect () =
    connexion_au_serveur !machine !port;
    board := recevoir_un_message_du_serveur ();
;;

let speclist = [
    ("-port", Arg.Int (fun p -> port := p), "Spécifie le port du serveur (8888 par defaut)");
    ("-machine", Arg.String (fun p -> machine := p), "Spécifie l'adresse ip du serveur (127.0.0.1 par defaut)");
    ];;
let usage = "Client de jeu Bomberman";;
Arg.parse speclist print_endline usage;;

connect ();;
initBoard !board;;
gameLoop () ;;
