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

<<<<<<< HEAD
(****aux1 : coord_joueurs = fonction qui separe les infos/ de la carte*****)
let get_info_string str = let l = Str.split (Str.regexp "[=]+") str
				in 
				List.hd l 
;;

(****aux2 : coord_joueurs = fonction qui separe les infos de chaque clients*******)
let get_info_client str = let l = Str.split (Str.regexp "\n") str
				in l 
;;

(******aux3 : coord_joueurs = fonction qui renvoie le quadruplet***********)
let quadruplet str = let l = Str.split (Str.regexp " ") str
			in 
			(lect_color (List.nth l 0) , int_of_string (List.nth l 1), int_of_string (List.nth l 2), lect_dir (List.nth l 0) );; 


(*** aux4 : coord_joueurs = fonction qui transforme string en quadruplet**)
let info l = List.map quadruplet l ;;

(*** aux0-4 ----> coord_joueurs **)
let coord_joueurs carte = info (get_info_client( get_info_string( carte_to_string carte)));;

(***fonction List_to_array appliquée à coord_joueurs renvoi un tableau de quadruplets****) 
let list_to_array l = 
match l with
| [] -> [| |] 
| e :: _ ->
let ar = Array.make (List.length l) e in
let f index elem = 
ar.(index) <- elem;
index + 1 in
ignore (List.fold_left f 0 l);
ar 
;;

=======
(** Envoi les coordonné du joueur (color, x, y, dir) au client c*)
let convert_pos (color, x, y, dir) = 
    {x = (x*width)+p_width; y = (y*heigth)+p_heigth; couleur = color; dir = dir; etat = Vivant; pas = None};
;;

(** Envoi le message m à tout les clients *)
let broadcast  m =
    List.iter (fun a -> envoyer_message_au_client m a) !clients;
;;

>>>>>>> 94bfce38ec580df5e7dc23ac6975b37d96817868
(*******************  PRGM  ***************)

let initMap () =
    Printf.printf "INIT SERVEUR MAP\n";
    let map = "==========\n=    x   =\n=  = ==  =\n= x  =   =\n= =  =   =\n= x  =   =\n= =  x = =\n=  =  =  =\n==========\n" in
    position := Array.of_list (coord_joueurs Sys.argv.(1));
    nbr_joueur := Array.length !position;
    players := Hashtbl.create !nbr_joueur;
    board := read_map map;
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
        | DeconnexionClient c -> ()
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
    ) !clients;
;;

let check_fin () =
    let cpt = List.fold_left (fun a c -> 
        if (Hashtbl.find !players c).etat = Mort then
            a + 1
        else
            a;
    ) 0 !clients in
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
    broadcast (Fin true);
    Printf.printf "PARTIE FINI\n";
;;
<<<<<<< HEAD
(*****  test : coord_joueurs  *****)
let rec aff l =
		match l with
		|[] -> ()	
		|x::s -> match x with |(a,b,c,d) -> print_int b; print_int c; aff s ;;

let h = coord_joueurs Sys.argv.(1) in aff h;;

let () = match (list_to_array (coord_joueurs Sys.argv.(1))).(1) with (a,b,c,d) -> print_int b;print_int b;print_int b;print_int b;;

=======
>>>>>>> 94bfce38ec580df5e7dc23ac6975b37d96817868

initMap ();;
run () ;;
gameLoop ();;
