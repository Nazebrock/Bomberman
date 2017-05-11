(*** options "machine" et "port" pour le prog:bomberman ***)

let bbman_options arg = 
		let port = ref 0 in
		let machine = ref 0
		in match Sys.argv.(arg+1) with
					|"-port" -> port := int_of_string ( Sys.argv.(arg+2) ); !port
					|"-machine" -> machine := int_of_string (Sys.argv.(arg+2)); !machine 
					| _ -> 000
(*cette fonction renvoie les valeurs des options en fonction du nbre d'options en entrée du prog*)
let () =
match Array.length Sys.argv with 5 ->
		print_int (bbman_options 2);
		print_int (bbman_options 0)
				|3 -> print_int (bbman_options 0)
				|_->();;


(*** options "speed" et "port", "nbjoueurs", "nbarenes" pour le prog: serveur ***)

let bbman_options_serveur arg = 
		let port = ref 0 in
		let nbjoueurs = ref 0 in	
		let speed = ref 0 in
		let nbarenes = ref 0 in 
		match Sys.argv.(arg+1) with
					|"-port" -> port := int_of_string ( Sys.argv.(arg+2) ); !port
					|"-nbj" -> nbjoueurs := int_of_string (Sys.argv.(arg+2)); !nbjoueurs
					|"-speed" -> speed := int_of_string (Sys.argv.(arg+2)); !speed
					|"-nbarenes" -> nbarenes := int_of_string (Sys.argv.(arg+2)); !nbarenes
					| _ -> 000
(*cette fonction renvoie les valeurs des options en fonction du nbre d'options en entrée du prog*)
let () =
match Array.length Sys.argv with |9 ->  print_int (bbman_options_serveur 6);print_int (bbman_options_serveur 4);
						print_int (bbman_options_serveur 2);print_int (bbman_options_serveur 0)
				 |7 ->  print_int (bbman_options_serveur 4); print_int(bbman_options_serveur 2);
					print_int (bbman_options_serveur 0)
				 |5 -> print_int (bbman_options_serveur 2);print_int (bbman_options_serveur 0)
				 |3 -> print_int (bbman_options_serveur 0)
				 |0 ->  ()
			         |_->();;
