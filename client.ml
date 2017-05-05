open Gtypes;;
open Player;;
open Bombe;;
open String;;
let width = 92;;
let heigth = 72;;
let p_width = 48;;
let p_heigth = 70;;
let nbr_col = ref 0;;
let nbr_lig = ref 0;;

(* Initialise un joueur *)
let player = ref {x=116;y=107;couleur=Bleu;dir=Nord;etat=Vivant;pas=Some 0};;

(** Plateau
 *  0 = Sol
 *  1 = Bombe
 *  2 = flamme
 *  10 = Cassable Brise 
 *  11 = Cassable Intact
 *  12 = incassable
 *)
let board = ref [||];;

(** Stock les bombes active *)
let active_bombe = ref [];;
(** Stock les bombes en train d'exploser *)
let explosing_bombe = ref [];;

let read_map map = 
    let b = ref [] in let ligne = ref [] in
    Printf.printf "Board %d\n" (String.length map);
    String.iter (function
        | '=' -> ligne := !ligne@[12]
        | 'x' -> ligne := !ligne@[11]
        | '\n'-> b := !b@[Array.of_list !ligne]; ligne := []
        | _ -> ligne := !ligne@[0]
    ) map;
    board := Array.of_list !b;
;;

let initBoard b =
    Printf.printf "INIT BOARD\n";
    Array.iter (fun a -> Array.iter (function
        |12 -> Printf.printf "="
        |11 -> Printf.printf "x"
        | 0 -> Printf.printf " "
    ) a; Printf.printf "\n") b;
    nbr_col := Array.length b.(0);
    nbr_lig := Array.length b;
    Printf.printf "Board %d %d\n" !nbr_col !nbr_lig;
    Ig.init width heigth !nbr_col !nbr_lig;
    for i = 0 to !nbr_lig - 1  do
        for j = 0 to !nbr_col - 1 do
            if b.(i).(j) = 11 then
                Ig.affiche_sprite (Bloc {blk_i = i; blk_j = j; blk_forme = Cassable Intact})
            else if b.(i).(j) = 12 then
                Ig.affiche_sprite (Bloc {blk_i = i; blk_j = j; blk_forme = Incassable})
        done;
    done;
    Ig.affiche (); 
;;

let refresh_player () =
    check_player player !board;
    match !player.etat with
        | Vivant -> Ig.efface_sprite (Bomberman !player);
                    player := move_player player !board;
                    Ig.affiche_sprite (Bomberman !player);
        | Grille -> Ig.efface_sprite (Bomberman !player);
                    Ig.affiche_sprite (Bomberman !player);
                    player := {!player with etat = Mort};
        | Mort ->   Ig.efface_sprite (Bomberman !player);
                    Ig.affiche_sprite (Bomberman !player);
;;

let gameLoop () =
    let fin = ref false in
    let bombe = ref false in
    while not !fin do
        Unix.sleepf 0.03;
        if Ig.touche_pressee () then
            begin
                let c = Ig.lecture_touche () in
                if c = 'b' then
                    add_bombe (!player.x/width) (!player.y/heigth) !board active_bombe
                else
                    change_dir_player player c
            end
        else
            player := !player;
        if !bombe then 
            refresh_bombe active_bombe explosing_bombe
        else
            explode_bombe explosing_bombe !board;
        refresh_player ();
        Ig.affiche ();
        bombe := not !bombe;
    done;
;;

let map = "==========\n=    x   =\n=  = ==  =\n= x  =   =\n= =  =   =\n= x  =   =\n= =  x = =\n=  =  =  =\n==========\n";;

read_map map;;
initBoard !board;;
Printf.printf "Game RUNNING\n";
gameLoop () ;;
