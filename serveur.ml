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


(** Envoi les coordonné du joueur (color, x, y, dir) au client c*)

let convert_pos (color, x, y, dir) = 
    {x = x; y = y; couleur = color; dir = dir; etat = Vivant; pas = None};
;;

(** Envoi le message m à tout les clients *)
let broadcast  m =
    List.iter (fun a -> envoyer_message_au_client m a) !clients;
;;

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

