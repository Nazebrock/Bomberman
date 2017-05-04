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
    if board.(x / width).(y / heigth) > 9 then
        false
    else
        true
;;

(** Modifie la position du joueur en fonction de sa direction
 *  Prend en compte les colisions avec les bloc et les bord du plateau *)
let move_player () =
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

let add_bombe () =
    let x = !player.x/width in let y = !player.y/heigth in
    if board.(x).(y) = 0 then begin
        board.(x).(y) <- 1;
        let b = {b_i = x; b_j = y; b_duree = 16} in
        active_bombe := !active_bombe@[b];
    end
;;

let check_player x y =
    if (!player.x/width) = x && (!player.y/heigth) = y then
        player := {!player with etat = Grille}
;;

let add_flamme x y =
    let dir = [|[|1;0|] ; [|-1;0|] ; [|0;1|] ; [|0;-1|]|] in
    let forme = [|FDroite;FGauche;FHaut;FBas|] in
    board.(x).(y) <- 2;
    Ig.affiche_sprite (Flamme {f_i = x; f_j = y; f_forme = FCroix});
    for i = 0 to 3 do
        let b_i = x+dir.(i).(0) in let b_j = y+dir.(i).(1) in
        try
            let case = board.(b_i).(b_j) in
            match case with
                | 11 -> board.(b_i).(b_j) <- 10;
                        Ig.affiche_sprite (Bloc {blk_i = b_i; blk_j = b_j; blk_forme = Cassable Brise});
                | 12 -> ()
                | _ -> board.(b_i).(b_j) <- 2;
                        Ig.affiche_sprite (Flamme {f_i = b_i; f_j = b_j; f_forme = forme.(i)});
            check_player x y;
        with Invalid_argument  s -> ();
    done;
;;

let remove_flamme x y =
    let dir = [|[|1;0|] ; [|-1;0|] ; [|0;1|] ; [|0;-1|]|] in
    board.(x).(y) <- 0;
    Ig.efface_sprite (Flamme {f_i = x; f_j = y; f_forme = FCroix});
    for i = 0 to 3 do
        let b_i = x+dir.(i).(0) in let b_j = y+dir.(i).(1) in
        try
            let case = board.(b_i).(b_j) in
            if case = 2 then begin
                board.(b_i).(b_j) <- 0;
                Ig.efface_sprite (Flamme {f_i = b_i; f_j = b_j; f_forme = FCroix});
            end
        with Invalid_argument  s -> ();
    done;
;;

let explode_bombe () =
    explosing_bombe := List.fold_left
        (fun l a ->
            let x = a.b_i in let y = a.b_j in
            if a.b_duree = -1 then begin
                remove_flamme x y;
                l
            end
            else begin
                add_flamme x y;
                {a with b_duree = -1}::l
            end
        ) [] !explosing_bombe;
;;

let refresh_bombe () = 
    active_bombe := List.fold_left 
        (fun l a ->
            if a.b_duree = 0 then begin
                explosing_bombe := !explosing_bombe@[{a with b_duree = -2}];
                l
            end
            else begin
                Ig.efface_sprite (Bombe a);
                let b = {a with b_duree = a.b_duree-1} in
                Ig.affiche_sprite (Bombe b);
                b::l
            end
        ) [] !active_bombe;
;;

let refresh_player () =
    match !player.etat with
        | Vivant -> Ig.efface_sprite (Bomberman !player);
                    move_player ();
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
                    add_bombe ()
                else
                    player := change_dir_player !player c
            end
        else
            player := !player;
        incr_pas ();
        if !bombe then 
            refresh_bombe ()
        else
            explode_bombe ();
        refresh_player ();
        Ig.affiche ();
        bombe := not !bombe;
    done;
;;


initBoard board;;
Printf.printf "Game RUNNING\n";
gameLoop () ;;
