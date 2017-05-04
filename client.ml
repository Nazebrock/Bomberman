open Gtypes;;
open Player;;
open Bombe;;

let pas = 5;;
let width = 92;;
let heigth = 72;;
let p_width = 48;;
let p_heigth = 70;;
let nbr_col = ref 0;;
let nbr_lig = ref 0;;
(* Initialise un joueur *)
let player = ref {x=100;y=100;couleur=Bleu;dir=Nord;etat=Vivant;pas=Some 0};;
let bloc = Bloc {blk_i = 5; blk_j = 5; blk_forme = Cassable Intact};;

(** Plateau
 *  0 = Sol
 *  1 = Bombe
 *  2 = flamme
 *  10 = Cassable Brise 
 *  11 = Cassable Intact
 *  12 = incassable
 *)
let board = Array.make_matrix 10 10 0;;
board.(5).(8) <- 11;;
board.(0).(0) <- 12;;
board.(9).(9) <- 11;;

(** Stock les bombes active *)
let active_bombe = ref [];;
(** Stock les bombes en train d'exploser *)
let explosing_bombe = ref [];;

let initBoard b =
    Printf.printf "INIT BOARD\n";
    nbr_col := Array.length b.(0);
    nbr_lig := Array.length b;
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
    check_player player board;
    match !player.etat with
        | Vivant -> Ig.efface_sprite (Bomberman !player);
                    player := move_player player board;
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
                    add_bombe (!player.x/width) (!player.y/heigth) board active_bombe
                else
                    change_dir_player player c
            end
        else
            player := !player;
        if !bombe then 
            refresh_bombe active_bombe explosing_bombe
        else
            explode_bombe explosing_bombe board;
        refresh_player ();
        Ig.affiche ();
        bombe := not !bombe;
    done;
;;


initBoard board;;
Printf.printf "Game RUNNING\n";
gameLoop () ;;
