(** Ce fichier contient l'interface r�seau pour le client et le
   serveur. Il comprend les fonctions pour d�marrer le serveur et pour
   s'y connecter ainsi que des fonctions pour recevoir et envoyer des
   messages de type quelconque. *)

exception Erreur_Reseau of string
  (** L'exception lev�e en cas d'une erreur r�seau. *)

type client
  (** Type abstrait repr�sentant les connexions des clients. *)
  
(** Type repr�sentant les requ�tes des clients. *)
type 'a requete = 
    MessageClient of client * 'a 
      (** [MessageClient(c, m)] correspond au message �mis par un client. 
	Elle contient l'identification [c] du client ainsi que son message [m].
      *)
  | DeconnexionClient of client
      (** [Deconnection c] correspond � la d�connection du client [c].*)

(** {1 Serveur}

  Les fonctions suivantes sont utilis�es pour programmer la partie r�seau du
  serveur.*)

val demarrer_le_serveur : int -> unit
  (** [demarrer_le_serveur p] d�marre un serveur sur le port [p] de la
    machine locale.
    @raise Erreur_Reseau Si le serveur ne peut �tre d�marr�. *)

val envoyer_message_au_client : 'a -> client -> unit
  (** [envoyer_message_au_client m c ] envoie le message [m] au client
    [c] en bloquant le serveur jusqu'� ce que le client [c] ait effectivement
    re�u le message [m].*)

val attendre_connexion_client : unit -> client
  (** [attendre_connexion_client ()] bloque le serveur jusqu'� la
    connexion d'un nouveau client.
    @return L'identification [c] du nouveau client. *)

val lire_requetes_clients : client list -> 'a requete list
  (** [lire_requetes_clients cl] permet au serveur de r�cup�rer une ou
    plusieurs requ�tes des clients [cl] (ne bloque pas le serveur si
    aucune requ�te n'est pr�sente).  
    @return Liste de requ�tes envoy�es par les clients [cl]. *)


(** {1 Client}

  Les fonctions suivantes sont utilis�es pour programmer la partie r�seau d'un
  client de Bomberman.*)

val connexion_au_serveur : string -> int -> unit
  (** [connexion_au_serveur m p] connecte le client au serveur s'ex�cutant 
    sur la machine [m] et le port [p].
    @raise Erreur_Reseau Si le client ne peut se connecter au serveur. *)

val deconnection_du_serveur : unit -> unit
  (** [deconnection_du_serveur ()] d�connecte le client du serveur. *)

val envoyer_message_au_serveur : 'a -> unit
  (** [envoyer_message_au_serveur m] envoie le message [m] au serveur. *)

exception Aucun_Message

val recevoir_un_message_du_serveur : unit -> 'a
  (** [recevoir_un_message_du_serveur ()] re�oit un message �mis par le
    serveur. L'appel de fonction est bloquant.
    @return Le message �mis par le serveur.
    @raise Aucun_Message Si aucun message n'est disponible au moment de
    l'appel. *)

val appeler_regulierement_la_fonction : (unit -> unit) -> float -> unit
  (** [appeler_regulierement_la_fonction f t] appelle la fonction [f]
    toutes les [t] secondes. *)

val attendre_infiniment : exn -> unit
  (** [attendre_infiniment e] ne termine que lorsque l'exception [e] est
    lev�e. Cette exception doit �tre lev�e par une fonction appel�e
    r�guli�rement (voir [appeler_regulierement_la_fonction]). *)
