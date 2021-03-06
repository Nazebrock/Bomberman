open String;;
open Gtypes;;

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

(******aux3 : coord_joueurs = fonction qui renvoie le quadruplet***********)

let quadruplet str = let l = Str.split (Str.regexp " ") str
			in 
			(lect_color (List.nth l 0) , int_of_string (List.nth l 1), int_of_string (List.nth l 2), lect_dir (List.nth l 0) );; 


(*** aux4 : coord_joueurs = fonction qui transforme string en quadruplet**)
let info l = List.map quadruplet l ;;

(*** aux0-4 ----> coord_joueurs **)
let coord_joueurs carte = info (get_info_client( get_info_string( carte_to_string carte)));;   

let read_map file nbr_pos = 
    (** Recupere la carte *)
    let f = ref (Str.split (Str.regexp "\n") (carte_to_string file)) in
    for i = 1 to nbr_pos do f := (List.tl !f) done;
    (** Transforme la carte au format de Matrice d'entier *)
    let b = ref [] in let ligne = ref [] in
    for i = 0 to String.length (List.hd !f) -1 do
        List.iter ( fun str ->
            match str.[i] with
                | '=' -> ligne := 12::!ligne
                | 'x' -> ligne := 11::!ligne
                | '\n' -> ()
                | _ -> ligne := 0::!ligne;
        ) !f;
        b := !b@[(Array.of_list !ligne)]; 
        ligne := [];
    done;
    Array.of_list !b;
;;


let get_map carte = 
    let l = Str.split (Str.regexp "[=]+") (carte_to_string carte) in
    List.iter (Printf.printf "%s") (List.tl l);
    [||];
;;
