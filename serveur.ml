open Reseau;;

(*
communication serveur->client
*)
let ecoute() =
 demarrer_le_serveur 7885;
(*envoi du message de confirmation de connexion*)
 let c0 = attendre_connexion_client () 
	in
 	envoyer_message_au_client "vous êtes connecté au serveur" c0;

let reqlist = lire_requetes_clients [c0]
 	in
	match reqlist with
	|[] -> print_string "aucun msg dans boite aux lettres"
	|x::s -> match x with |MessageClient(c,m)-> print_string m
			      |DeconnexionClient(c) -> print_string "deconnexion"

;;
(*
lecture de carte: ouvrir_carte Sys.argv.(1);;
*)

let ouvrir_carte fichier = 
	let f1 = open_in fichier
	in 
		try while true do print_char (input_char f1) done
	with End_of_file -> close_in f1
;;

(*

*)
ecoute()


