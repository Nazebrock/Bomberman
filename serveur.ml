open Reseau;;

let boucle_Ecoute() =
 demarrer_le_serveur 7885;
 let c0 = attendre_connexion_client () in
 envoyer_message_au_client "vous êtes connecté au serveur" c0;
 print_string "message envoyé"
;;

boucle_Ecoute ();;

