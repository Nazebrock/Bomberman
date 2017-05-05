open Gtypes;;

let add_bombe x y board active_bombe =
    if board.(x).(y) = 0 then begin
        board.(x).(y) <- 1;
        let b = {b_i = x; b_j = y; b_duree = 16} in
        active_bombe := !active_bombe@[b];
    end
;;

let add_flamme x y board =
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
        with Invalid_argument  s -> ();
    done;
;;

let remove_flamme x y board =
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

let explode_bombe explosing_bombe board =
    explosing_bombe := List.fold_left
        (fun l a ->
            let x = a.b_i in let y = a.b_j in
            if a.b_duree = -1 then begin
                remove_flamme x y board;
                l
            end
            else begin
                add_flamme x y board;
                {a with b_duree = -1}::l
            end
        ) [] !explosing_bombe;
;;

let refresh_bombe active_bombe explosing_bombe = 
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

