open Reseau;;

let essai_Connexion() =
connexion_au_serveur "" 7885;
 let msg =
	let m=recevoir_un_message_du_serveur () in 
	match m with
	|string -> print_string m
 	|_->()
 in msg;
envoyer_message_au_serveur "salut je suis client";;

essai_Connexion () ;;



