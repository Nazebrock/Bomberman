open Reseau;;

let ecoute() =
 demarrer_le_serveur 7885;
 let c0 = attendre_connexion_client () 
	in
 	envoyer_message_au_client "vous êtes connecté au serveur" c0;
 let reqlist = lire_requetes_clients [c0]
 	in
	match reqlist with
	|[] -> print_string "aucun msg dans boite aux lettres"
	|x::s -> match x with |MessageClient(c,m)-> print_string m
			      |DeconnexionClient(c) -> print_string "deco"
;;

ecoute ()


