open Gtypes;;

let pas = 6;;
let width = 92;;
let heigth = 72;;
let p_width = 48;;
let p_heigth = 70;;

(** Change la direction en fonction du charactere reçu *)
let change_dir_player p = function
    | 'z' -> p := {!p with dir = Nord}
    | 'q' -> p := {!p with dir = Ouest}
    | 's' -> p := {!p with dir = Sud}
    | 'd' -> p := {!p with dir = Est}
    | _ -> ()
;;

(** Verifie que le point x y est sur une case libre *)
let check_point x y board =
    if board.(x / width).(y / heigth) > 9 then
        false
    else
        true
;;

(** Verifie si le joueur se fais toucher par une flamme *)
let check_player player board =
    let hitbox = [|
        [|(!player.x+(p_width/2))/width; !player.y/heigth|];
        [|(!player.x-(p_width/2))/width; !player.y/heigth|];
        [|!player.x/width; (!player.y+(p_heigth/2))/heigth|];
        [|!player.x/width; (!player.y-(p_heigth/2))/heigth|];
    |] in
    for i = 0 to 3 do
        if board.(hitbox.(i).(0)).(hitbox.(i).(1)) = 2 then
            player := {!player with etat = Grille}
    done;
;;

(** Incremente le champs pas du joueur *)
let incr_pas player =
    let a = 
    match !player.pas with
        |Some i ->
            if i > 2 then Some 0
            else Some (i + 1)
        |None -> None
    in
    {!player with pas = a}
;;

(** Modifie la position du joueur en fonction de sa direction
 *  Prend en compte les colisions avec les bloc et les bord du plateau *)
let move_player player board =
    player := incr_pas player;
    let nbr_lig = Array.length board in let nbr_col = Array.length board.(0) in
    match !player.dir with
        | Nord ->   
                let y = !player.y + (p_heigth/2) in let x = !player.x in
                if (y + pas) >= (nbr_lig * heigth) then 
                    {!player with y = (nbr_lig * heigth)-(p_heigth/2)-1}
                else if not (check_point (x + (p_width/2)) (y + pas) board) || 
                        not (check_point (x - (p_width/2)) (y + pas) board)
                then 
                    {!player with y = ((((y+pas)/heigth)*heigth)-(p_heigth/2))-1}
                else 
                    {!player with y = !player.y + pas}
        | Sud ->
                let y = !player.y - (p_heigth/2) in let x = !player.x in
                if (y - pas) <= 0 then
                    {!player with y = (p_heigth/2)}
                else if not (check_point (x + (p_width/2)) (y - pas) board) ||
                        not (check_point (x - (p_width/2)) (y - pas) board)
                then
                    {!player with y = (((!player.y/heigth)*heigth)+(p_heigth/2))}
                else
                    {!player with y = !player.y - pas}
        | Ouest -> 
                let y = !player.y in let x = !player.x - (p_width/2)in
                if (x - pas) <= 0 then
                    {!player with x = (p_width/2)}
                else if not (check_point (x - pas) (y + (p_heigth/2)) board) ||
                        not (check_point (x - pas) (y - (p_heigth/2)) board)
                then
                    {!player with x = (((!player.x/width)*width)+(p_width/2))}
                else
                    {!player with x = !player.x - pas}
        | Est ->
                let y = !player.y in let x = !player.x + (p_width/2)in
                if (x + pas) >= (nbr_col * width) then
                    {!player with x = (nbr_col * width)-(p_width/2)-1}
                else if not (check_point (x + pas) (y + (p_heigth/2)) board) ||
                        not (check_point (x + pas) (y - (p_heigth/2)) board)
                then
                    {!player with x = ((((x+pas)/width)*width)-(p_width/2))-1}
                else
                    {!player with x = !player.x + pas}
;;


