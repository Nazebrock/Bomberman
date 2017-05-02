open Unix

type client = file_descr
type 'a requete = 
    MessageClient of client*'a 
  | DeconnexionClient of client

exception Erreur_Reseau of string

let error e = Format.eprintf "%s\n@." e

let obtenir_adresse_ip machine = 
  let host = 
    try gethostbyname machine
    with
    | Not_found -> 
       error ("Attention: Impossible de trouver l'adresse de "^machine^
		", on utilise l'adresse locale de votre ordinateur à la place");
       gethostbyname "localhost" 
    | Unix_error(e,_,_) -> 
       error (error_message e); 
       exit 1
  in 
  try host.h_addr_list.(0) with Invalid_argument _ -> exit 1

let socket_serveur = socket PF_INET SOCK_STREAM 0
let outchan_serveur = out_channel_of_descr socket_serveur 
let socket_client = socket PF_INET SOCK_STREAM 0 

let connexion_au_serveur machine port =  
  try
    let machine = if machine="" then gethostname() else machine in
    let sockaddr = ADDR_INET(obtenir_adresse_ip machine,port) in
    connect socket_serveur sockaddr
  with Unix.Unix_error _ -> 
    let machine = if machine="" then "localhost" else machine in
    let m = machine^":"^(string_of_int port) in
    raise (Erreur_Reseau 
	     ("Impossible de se connecter au serveur sur "^m))

let deconnection_du_serveur () = 
  Unix.shutdown socket_serveur Unix.SHUTDOWN_SEND

let demarrer_le_serveur port = 
  try
    let machine_locale = gethostname() in
    let sockaddr = ADDR_INET(obtenir_adresse_ip machine_locale,port) in
    setsockopt socket_serveur SO_REUSEADDR true;
    bind socket_serveur sockaddr;
    listen socket_serveur 3
  with Unix.Unix_error _ -> 
    let m = "localhost:"^(string_of_int port) in
    raise (Erreur_Reseau ("Impossible de lancer le serveur sur "^m))

let envoyer_message_au_serveur m = 
  let s = Marshal.to_string m [] in
  ignore(send socket_serveur s 0 (Bytes.length s) []);
  flush outchan_serveur

let envoyer_message_au_client m client = 
  let s = Marshal.to_string m [] in
  let outchan_client = out_channel_of_descr client in 
  ignore(send client s 0 (Bytes.length s) []);
  flush outchan_client

let hs = Marshal.header_size
let header = Bytes.create hs

let rec lire_message_plus_header_suivant descr = 
  let len = Marshal.total_size header 0 in 
  let buf = Bytes.create (len+hs) in 
  Bytes.blit header 0 buf 0 hs; 
  let rcv = recv descr buf hs len [] in 
  let obj = Marshal.from_string buf 0 in
  if rcv < len then [obj]
  else begin
    Bytes.blit buf len header 0 hs; 
    obj::(lire_message_plus_header_suivant descr)
  end

let vider_file_messages descr = 
  if (recv descr header 0 hs []) < hs then []
  else lire_message_plus_header_suivant descr

exception Aucun_Message

let reception_msg_serveur =
  let reste = ref [] in 
  fun () -> 
    match !reste with 
      | m::l -> reste:=l; m
      | [] -> 
	  let ready,_,_ = Unix.select [socket_serveur] [] [] (-1.0) in
	  match ready with
	    | [] -> raise Aucun_Message
	    | [s] -> 
		(match vider_file_messages s with 
		   | [] -> raise Aucun_Message
		     | m::l -> reste:=l; m)
	    | _ -> assert(false)

let rec recevoir_un_message_du_serveur () =
  try reception_msg_serveur ()
  with Unix.Unix_error(e,_,_) -> recevoir_un_message_du_serveur ()

let requetes_clients tps ls = 
  let traitement_requete s =
    let l = vider_file_messages s in 
    if l=[] then [DeconnexionClient(s)] 
    else List.map (fun m -> MessageClient(s,m)) l
  in
  let ready,_,_ = select ls [] [] 0.0001 in
  List.concat (List.map traitement_requete ready)


let lire_requetes_clients = requetes_clients 0.0001

let attendre_connexion_client () = 
  let ready,_,_ = select [socket_serveur] [] [] (-1.0) in
  assert (List.length ready=1);
  fst (accept socket_serveur)

let appeler_regulierement_la_fonction f v = 
  let _ = Sys.set_signal Sys.sigalrm (Sys.Signal_handle (fun _ -> f ())) in
  ignore(Unix.setitimer Unix.ITIMER_REAL 
	   {Unix.it_interval= v ; Unix.it_value= v })

let attendre_infiniment e = 
  try
    while (true) do 
      try
	ignore(read_line()) 
      with x when x <> e -> ()
    done
  with 
    | x when x = e -> ()
    | _ -> assert false
