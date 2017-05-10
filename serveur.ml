open Reseau;;
open Gtypes;;
open Bombermap;;
open Player;;
open Bombe;;

let width = 92;;
let heigth = 72;;
let p_width = 48;;
let p_heigth = 70;;

(** Nombre de joueur possible sur cette map *)
let nbr_joueur = ref 1;;
(** Tableau des positions initiales au format : Color * int * int* Dir *)
let position = ref [||];;
(** Map des Sprites de joueur par rapport au client correspondant *)
let players = ref (Hashtbl.create 0);;
(** tableau contenant la map
 *  0 = Sol
 *  1 = Bombe
 *  2 = flamme
 *  10 = Cassable Brise 
 *  11 = Cassable Intact
 *  12 = incassable
*)
let board = ref [||];;
(** Liste des clients connecté *)
let clients = ref [];;
(** Liste de sprite a envoyer au client *)
let sprites = ref [];;
(** Stock les bombes en train d'exploser *)
let explosing_bombe = ref [];;
(** Stock les bombes active *)
let active_bombe = ref [];;

(** Envoi les coordonné du joueur (color, x, y, dir) au client c*)
let convert_pos (color, x, y, dir) = 
    {x = (x*width)+(p_width/2); y = (y*heigth)+(p_heigth/2); couleur = color; dir = dir; etat = Vivant; pas = Some 0};
;;

(** Envoi le message m à tout les clients *)
let broadcast  m =
    List.iter (fun a -> envoyer_message_au_client m a) !clients;
;;

(*******************  PRGM  ***************)

let initMap () =
    Printf.printf "INIT SERVEUR MAP\n";
    position := Array.of_list (coord_joueurs Sys.argv.(1));
    nbr_joueur := Array.length !position;
    players := Hashtbl.create !nbr_joueur;
    board := read_map Sys.argv.(1) (Array.length !position);
;;

let run () = 
    Printf.printf "START SERVEUR\n";
    demarrer_le_serveur 7885;
    for i = 0 to !nbr_joueur - 1 do
        let c = attendre_connexion_client () in
        envoyer_message_au_client !board c;
        clients := !clients@[c];
        Hashtbl.add !players c (convert_pos !position.(i));
    done;
;;

let traite_req reqs =
    List.iter (function
        | MessageClient (c,m) -> 
                (match m with
                    | 'z' -> Hashtbl.replace !players c {(Hashtbl.find !players c) with dir = Nord}
                    | 's' -> Hashtbl.replace !players c {(Hashtbl.find !players c) with dir = Sud}
                    | 'q' -> Hashtbl.replace !players c {(Hashtbl.find !players c) with dir = Ouest}
                    | 'd' -> Hashtbl.replace !players c {(Hashtbl.find !players c) with dir = Est}
                    | 'b' -> let p = Hashtbl.find !players c in
                             add_bombe (p.x/width) (p.y/heigth) !board active_bombe;
                    | _ -> ())
        | DeconnexionClient c -> 
                Hashtbl.replace !players c {(Hashtbl.find !players c) with etat = Mort};
                sprites := !sprites@[Efface (Bomberman (Hashtbl.find !players c))];
                sprites := !sprites@[Affiche (Bomberman (Hashtbl.find !players c))];
                clients := List.fold_left (fun l cl -> if cl = c then l else l@[cl]) [] !clients;
    ) reqs;
;;

let refresh_players () =
    List.iter (fun c ->
        let p = ref (Hashtbl.find !players c) in
        sprites := !sprites@[Efface (Bomberman !p)];
        p := check_player !p !board;
        match !p.etat with
            | Vivant -> p := (move_player !p !board);
                        Hashtbl.replace !players c !p;
                        sprites := !sprites@[Affiche (Bomberman !p)];
            | Grille -> sprites := !sprites@[Affiche (Bomberman !p)];
                        p := {!p with etat = Mort};
                        Hashtbl.replace !players c !p;
            | Mort ->   sprites := !sprites@[Affiche (Bomberman !p)];
    ) !clients;
;;

let check_fin () =
    let cpt = Hashtbl.fold (fun k v a -> 
        if v.etat = Mort then
            a + 1
        else
            a;
    ) !players 0 in
    cpt = !nbr_joueur;
;;

let gameLoop () =
    Printf.printf "START GAME\n";
    let fin = ref false in
    let bombe = ref false in
    while not !fin do 
        Unix.sleepf 0.03;
        let reqs = lire_requetes_clients !clients in
        traite_req reqs;
        if !bombe then
            sprites := !sprites@(refresh_bombe active_bombe explosing_bombe)
        else
            sprites := !sprites@(explode_bombe explosing_bombe !board);
        refresh_players ();
        broadcast !sprites;
        sprites := [];
        bombe := not !bombe;
        fin := check_fin ();
    done;
    Unix.sleep 1;
    broadcast (Fin true);
    Unix.sleep 1;
    Printf.printf "PARTIE FINI\n";
;;

initMap ();;
run () ;;
gameLoop ();;
