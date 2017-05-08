open Reseau;;
open Gtypes;;
open Bombermap;;

let nbr_joueur = ref 1;;
let position = [|(Bleu,1,1,Sud)|];;
let map = ref "==========\n=    x   =\n=  = ==  =\n= x  =   =\n= =  =   =\n= x  =   =\n= =  x = =\n=  =  =  =\n==========\n";;
let clients = ref [];;
(*
communication serveur->client
*)

let rec ecoute client = 
	let reqlist = lire_requetes_clients [client]
 	in match reqlist with
	|[] -> print_string "aucun msg dans boite aux lettres"; ecoute client
	|x::s -> match x with   |MessageClient(c,m) -> print_string m; ecoute client
			     			|DeconnexionClient(c) -> (); ecoute client


(*****  test : coord_joueurs  *****)
let rec aff l =
		match l with
		|[] -> ()	
		|x::s -> match x with |(a,b,c,d) -> print_int b; print_int c; aff s ;;
let h = coord_joueurs Sys.argv.(1) in aff h;;


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
    {x = x; y = y; couleur = color; dir = dir; etat = Vivant; pas = None};
;;

(** Envoi le message m à tout les clients *)
let broadcast  m =
    List.iter (fun a -> envoyer_message_au_client m a) !clients;
;;

>>>>>>> 94bfce38ec580df5e7dc23ac6975b37d96817868
(*******************  PRGM  ***************)
let run () = 
    demarrer_le_serveur 7885;
    for i = 0 to !nbr_joueur - 1 do
        let c = attendre_connexion_client () in
        envoyer_message_au_client !map c;
        envoyer_message_au_client !nbr_joueur c;
        clients := !clients@[c];
        broadcast (convert_pos position.(i));
    done;
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

