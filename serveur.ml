open Reseau;;
open Gtypes;;
open String;;


let nbr_joueur = ref 0;;
let map = "==========\n=    x   =\n=  = ==  =\n= x  =   =\n= =  =   =\n= x  =   =\n= =  x = =\n=  =  =  =\n==========\n";;


(****Renvoi le nombre de joueurs de la carte***)
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
(****utile**string-->Gtypes.color********)
let lect_color str = match str with 
				|"bleu" -> Bleu
				|"vert" -> Vert
				|"rouge" -> Rouge
				|"violet" -> Violet
				|_ -> Bleu
;;

(****utile***string-->Gtypes.direction********)
let lect_dir str = match str with 
				|"Ouest" -> Ouest
				|"Nord" -> Nord
				|"Sud" -> Sud
				|"Est" -> Est
				|_ -> Nord
;;

(*** aux0 : coord_joueurs = prends la carte et renvoie une string contenant les infos et la carte***)
let carte_to_string fichier_carte = 
	let src = open_in fichier_carte in 				
		let str = ref "" in
		begin
			try
			while true do 
						str := !str^"\n"^(input_line src);
			done
			with End_of_file -> ();
			end;
 !str;;

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

(*******************  PRGM  ***************)
let clients = ref []
let run () = 
	demarrer_le_serveur 7885;
	for i = 1 to !nbr_joueur do
		clients := !clients@[attendre_connexion_client ()];
	done
;;
(*****  test : coord_joueurs  *****)
let rec aff l =
		match l with
		|[] -> ()	
		|x::s -> match x with |(a,b,c,d) -> print_int b; print_int c; aff s ;;

let h = coord_joueurs Sys.argv.(1) in aff h;;

let () = match (list_to_array (coord_joueurs Sys.argv.(1))).(1) with (a,b,c,d) -> print_int b;print_int b;print_int b;print_int b;;


