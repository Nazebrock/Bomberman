open Reseau;;

(*
communication serveur->client
*)

let rec ecoute client = 
	let reqlist = lire_requetes_clients [client]
 	in match reqlist with
	|[] -> print_string "aucun msg dans boite aux lettres"; ecoute client
	|x::s -> match x with   |MessageClient(c,m) -> print_string m; ecoute client
			     			|DeconnexionClient(c) -> (); ecoute client

(*
lecture de carte: ouvrir_carte Sys.argv.(1);;
*)

let ouvrir_carte fichier = 
	let f1 = open_in fichier
	in 
	try while true do print_char (input_char f1) done
	with End_of_file -> close_in f1
;;

(*--PRGM--*)

demarrer_le_serveur 7885;;
let c = attendre_connexion_client ()
in envoyer_message_au_client "vous êtes connecté au serveur" c; ecoute c;;



