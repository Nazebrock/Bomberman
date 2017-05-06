open Reseau;;
open Gtypes;;
open String;;

let nbr_joueur = ref 0;;
let map = "==========\n=    x   =\n=  = ==  =\n= x  =   =\n= =  =   =\n= x  =   =\n= =  x = =\n=  =  =  =\n==========\n";;
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

let nb_joueur carte =
    let fichier = open_in carte in
    let k = ref 0 in
    begin
      try
        while true do
        match input_char fichier with
        |'\n'-> k := !k + 1
        |'=' -> raise End_of_file
        |_ -> k:= !k
        done
      with
      | End_of_file -> ();
    end;
   !k
;;
(********************)

(***********************)

let info_clients carte = 
	let cpteur = ref 0 in
	let tableau_info =  ref Array.make (nb_joueur carte) ("vide","vide","vide","vide") in
	let fichier = open_in carte in
	try 
	while true 
	do 
	let first_char = input_char fichier in
	match first_char with |'=' -> raise End_of_file
			      |_   ->    cpteur := !cpteur +1 ;   let c = String.make 1 first_char in
					 let l = Str.split (Str.regexp " ") (c^(input_line fichier)) in
					 tableau_info.(!cpteur-1) = (List.nth l 0, List.nth l 1, List.nth l 2, List.nth l 3);
	done
	with 
	|End_of_file -> tableau_info;;

(**  print_string(c^input_line fichier )  **)


(********************)

let ouvrir_carte fichier = 
	let f1 = open_in fichier
	in 
	try while true do print_char (input_char f1) done
	with End_of_file -> close_in f1
;;

(*--PRGM--*)
let clients = ref []
let run () = 
	demarrer_le_serveur 7885;
	for i = 1 to !nbr_joueur do
		clients := !clients@[attendre_connexion_client ()];
	done;
;;

info_clients Sys.argv.(1);;



