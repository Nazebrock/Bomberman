open Gtypes;;

(** Ajoute la bombe sur le plateau si c'est possible *)
let add_bombe x y board active_bombe =
    if board.(x).(y) = 0 then begin
        board.(x).(y) <- 1;
        let b = {b_i = x; b_j = y; b_duree = 16} in
        active_bombe := !active_bombe@[b];
    end
;;

(** Ajoute des sprites de flamme autour de la bombe en x,y
 * Renvoi la liste de sprites associé *)
let add_flamme x y board =
    let dir = [|[|1;0|] ; [|-1;0|] ; [|0;1|] ; [|0;-1|]|] in
    let forme = [|FDroite;FGauche;FHaut;FBas|] in
    let sprites = ref [] in
    board.(x).(y) <- 2;
    sprites := !sprites@[Affiche (Flamme {f_i = x; f_j = y; f_forme = FCroix})];
    for i = 0 to 3 do
        let b_i = x+dir.(i).(0) in let b_j = y+dir.(i).(1) in
        try
            let case = board.(b_i).(b_j) in
            match case with
                | 11 -> board.(b_i).(b_j) <- 10;
                        sprites := !sprites@[Affiche (Bloc {blk_i = b_i; blk_j = b_j; blk_forme = Cassable Brise})];
                | 12 -> ()
                | _ -> board.(b_i).(b_j) <- 2;
                        sprites := !sprites@[Affiche (Flamme {f_i = b_i; f_j = b_j; f_forme = forme.(i)})];
        with Invalid_argument  s -> ();
    done;
    !sprites;
;;

(** Enleve les sprites de flamme autour de la bombe en x,y
 * Renvoi la liste de sprite associé *)
let remove_flamme x y board =
    let dir = [|[|1;0|] ; [|-1;0|] ; [|0;1|] ; [|0;-1|]|] in
    let sprites = ref [] in
    board.(x).(y) <- 0;
    sprites := !sprites@[Efface  (Flamme {f_i = x; f_j = y; f_forme = FCroix})];
    for i = 0 to 3 do
        let b_i = x+dir.(i).(0) in let b_j = y+dir.(i).(1) in
        try
            let case = board.(b_i).(b_j) in
            if case = 2 then begin
                board.(b_i).(b_j) <- 0;
                sprites := !sprites@[Efface (Flamme {f_i = b_i; f_j = b_j; f_forme = FCroix})];
            end
        with Invalid_argument  s -> ();
    done;
    !sprites;
;;

(** Met a jour la liste des bombe en explosion
 * Renvoi la liste de sprites associé *)
let explode_bombe explosing_bombe board =
    let sprites = ref [] in
    explosing_bombe := List.fold_left
        (fun l a ->
            let x = a.b_i in let y = a.b_j in
            if a.b_duree = -1 then begin
                sprites := !sprites@(remove_flamme x y board);
                l
            end
            else begin
                sprites := !sprites@(add_flamme x y board);
                {a with b_duree = -1}::l
            end
        ) [] !explosing_bombe;
    !sprites;
;;

(** Met a jour la liste des bombe active avant explosion
 * Renvoi la liste de sprites associé *)
let refresh_bombe active_bombe explosing_bombe = 
    let sprites = ref [] in
    active_bombe := List.fold_left 
        (fun l a ->
            if a.b_duree = 0 then begin
                explosing_bombe := !explosing_bombe@[{a with b_duree = -2}];
                l
            end
            else begin
                sprites := !sprites@[Efface (Bombe a)];
                let b = {a with b_duree = a.b_duree-1} in
                sprites := !sprites@[Affiche (Bombe b)];
                b::l
            end
        ) [] !active_bombe;
    !sprites;
;;

