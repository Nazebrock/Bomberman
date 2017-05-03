open Gtypes;;

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
 *  1 = Cassable
 *  2 = incassable
 *)
let board = Array.create_matrix 10 10 0;;
board.(5).(8) <- 1;;
board.(0).(0) <- 2;;
board.(9).(9) <- 1;;
let initBoard b =
    Printf.printf "INIT BOARD\n";
    nbr_col := Array.length b.(0);
    nbr_lig := Array.length b;
    Ig.init width heigth !nbr_col !nbr_lig;
    for i = 0 to !nbr_lig - 1  do
        for j = 0 to !nbr_col - 1 do
            if b.(i).(j) = 1 then
                Ig.affiche_sprite (Bloc {blk_i = i; blk_j = j; blk_forme = Cassable Intact})
            else if b.(i).(j) = 2 then
                Ig.affiche_sprite (Bloc {blk_i = i; blk_j = j; blk_forme = Incassable})
        done;
    done;
    Ig.affiche_sprite (Bomberman !player);
    Ig.affiche (); 
;;

(** Change la direction en fonction du charactere reçu *)
let change_dir_player p = function
    | 'z' -> {!player with dir = Nord}
    | 'q' -> {!player with dir = Ouest}
    | 's' -> {!player with dir = Sud}
    | 'd' -> {!player with dir = Est}
    | _ -> !player
;;

(** Verifie que le point x y est sur une case libre *)
let check_point x y =
    Printf.printf "Check %d %d = Case %d %d\n" x y (x / width) (y / heigth);
    if board.(x / width).(y / heigth) != 0 then
        false
    else
        true
;;

let move_player () =
    Ig.efface_sprite (Bomberman !player);
    let new_p = match !player.dir with
        | Nord ->   
                let y = !player.y + (p_heigth/2) in let x = !player.x in
                if (y + pas) >= (!nbr_lig * heigth) then 
                    {!player with y = (!nbr_lig * heigth)-(p_heigth/2)-1}
                else if not (check_point (x + (p_width/2)) (y + pas)) || 
                        not (check_point (x - (p_width/2)) (y + pas))
                then 
                    {!player with y = ((((y+pas)/heigth)*heigth)-(p_heigth/2))-1}
                else 
                    {!player with y = !player.y + pas}
        | Sud ->
                let y = !player.y - (p_heigth/2) in let x = !player.x in
                if (y - pas) <= 0 then
                        {!player with y = (p_heigth/2)}
                    else if not (check_point (x + (p_width/2)) (y - pas)) ||
                            not (check_point (x - (p_width/2)) (y - pas))
                    then
                        {!player with y = (((!player.y/heigth)*heigth)+(p_heigth/2))}
                    else
                        {!player with y = !player.y - pas}
        | Ouest -> 
                let y = !player.y in let x = !player.x - (p_width/2)in
                if (x - pas) <= 0 then
                    {!player with x = (p_width/2)}
                else if not (check_point (x - pas) (y + (p_heigth/2))) ||
                        not (check_point (x - pas) (y - (p_heigth/2)))
                then
                    {!player with x = (((!player.x/width)*width)+(p_width/2))}
                else
                    {!player with x = !player.x - pas}
        | Est ->
                let y = !player.y in let x = !player.x + (p_width/2)in
                if (x + pas) >= (!nbr_col * width) then
                        {!player with x = (!nbr_col * width)-(p_width/2)-1}
                    else if not (check_point (x + pas) (y + (p_heigth/2))) ||
                            not (check_point (x + pas) (y - (p_heigth/2)))
                    then
                        {!player with x = ((((x+pas)/width)*width)-(p_width/2))-1}
                    else
                        {!player with x = !player.x + pas}
    in
    player := new_p;
    Ig.affiche_sprite (Bomberman !player);
;;

(** Incremente le champs pas du joueur *)
let incr_pas () =
    let a = 
    match !player.pas with
        |Some i ->
            if i > 2 then Some 0
            else Some (i + 1)
        |None -> None
    in
    player := {!player with pas = a}
;;

let gameLoop () =
    let fin = ref false in
    while not !fin do
        Unix.sleepf 0.03;
        if Ig.touche_pressee () then
            begin
                player := change_dir_player !player (Ig.lecture_touche ());
            end
        else
            player := !player;
        incr_pas ();
        move_player ();
        Ig.affiche ();
    done;
;;


initBoard board;;
Printf.printf "Game RUNNING\n";
gameLoop () ;;
