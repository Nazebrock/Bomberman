(** Ce fichier contient l'interface réseau pour le client et le
   serveur. Il comprend les fonctions pour démarrer le serveur et pour
   s'y connecter ainsi que des fonctions pour recevoir et envoyer des
   messages de type quelconque. *)

exception Erreur_Reseau of string
  (** L'exception levée en cas d'une erreur réseau. *)

type client
  (** Type abstrait représentant les connexions des clients. *)
  
(** Type représentant les requêtes des clients. *)
type 'a requete = 
    MessageClient of client * 'a 
      (** [MessageClient(c, m)] correspond au message émis par un client. 
	Elle contient l'identification [c] du client ainsi que son message [m].
      *)
  | DeconnexionClient of client
      (** [Deconnection c] correspond à la déconnection du client [c].*)

(** {1 Serveur}

  Les fonctions suivantes sont utilisées pour programmer la partie réseau du
  serveur.*)

val demarrer_le_serveur : int -> unit
  (** [demarrer_le_serveur p] démarre un serveur sur le port [p] de la
    machine locale.
    @raise Erreur_Reseau Si le serveur ne peut être démarré. *)

val envoyer_message_au_client : 'a -> client -> unit
  (** [envoyer_message_au_client m c ] envoie le message [m] au client
    [c] en bloquant le serveur jusqu'à ce que le client [c] ait effectivement
    reçu le message [m].*)

val attendre_connexion_client : unit -> client
  (** [attendre_connexion_client ()] bloque le serveur jusqu'à la
    connexion d'un nouveau client.
    @return L'identification [c] du nouveau client. *)

val lire_requetes_clients : client list -> 'a requete list
  (** [lire_requetes_clients cl] permet au serveur de récupérer une ou
    plusieurs requêtes des clients [cl] (ne bloque pas le serveur si
    aucune requête n'est présente).  
    @return Liste de requêtes envoyées par les clients [cl]. *)


(** {1 Client}

  Les fonctions suivantes sont utilisées pour programmer la partie réseau d'un
  client de Bomberman.*)

val connexion_au_serveur : string -> int -> unit
  (** [connexion_au_serveur m p] connecte le client au serveur s'exécutant 
    sur la machine [m] et le port [p].
    @raise Erreur_Reseau Si le client ne peut se connecter au serveur. *)

val deconnection_du_serveur : unit -> unit
  (** [deconnection_du_serveur ()] déconnecte le client du serveur. *)

val envoyer_message_au_serveur : 'a -> unit
  (** [envoyer_message_au_serveur m] envoie le message [m] au serveur. *)

exception Aucun_Message

val recevoir_un_message_du_serveur : unit -> 'a
  (** [recevoir_un_message_du_serveur ()] reçoit un message émis par le
    serveur. L'appel de fonction est bloquant.
    @return Le message émis par le serveur.
    @raise Aucun_Message Si aucun message n'est disponible au moment de
    l'appel. *)

val appeler_regulierement_la_fonction : (unit -> unit) -> float -> unit
  (** [appeler_regulierement_la_fonction f t] appelle la fonction [f]
    toutes les [t] secondes. *)

val attendre_infiniment : exn -> unit
  (** [attendre_infiniment e] ne termine que lorsque l'exception [e] est
    levée. Cette exception doit être levée par une fonction appelée
    régulièrement (voir [appeler_regulierement_la_fonction]). *)
