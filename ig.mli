(** Ce fichier contient les primitives graphiques utiles pour le client du jeu 
  Bomberman. *)

val nb_pas_par_robot : int
  (** Nombre de pas décomposant la marche d'un robot. *)

val nb_images_par_bombe : int
  (** Nombre d'images représentant le décompte d'une bombe avant son
    explosion. *)

exception Erreur_Graphique of string

val affiche_sprite: Gtypes.sprite -> unit
  (** [affiche_sprite s] prépare l'affichage du sprite [s] dans la mémoire
    graphique : cette fonction ne modifie pas l'affichage sur l'écran, 
    elle ne modifie que la mémoire.
    @raise Erreur_Graphique si l'image correspondant au sprite n'existe pas. *)

val efface_sprite : Gtypes.sprite -> unit
  (** [efface_sprite s] remplace le sprite [s] par un fond de couleur gris 
    dans la mémoire graphique : cette fonction ne modifie pas l'affichage sur 
    l'écran, elle ne modifie que la mémoire. *)

val affiche: unit -> unit
  (** Affiche le contenu de la mémoire graphique à l'écran. *)

val touche_pressee: unit -> bool 
  (** Indique si une touche a été pressée par l'utilisateur.
    Cette fonction n'est pas bloquante.
    @return [true] si une touche a été pressée, [false] sinon. *)

val lecture_touche: unit -> char
  (** Attend que l'utilisateur presse une touche.
    Cette fonction est donc bloquante.
    @return Le caractère associé à la touche pressée par l'utilisateur. *)

val init: int -> int -> int -> int -> unit
  (** [init dim_x dim_y nb_col nb_lig] ouvre une fenêtre graphique de dimension
    [(dim_x * nb_col) x (dim_y * nb_lig)] (avec la coordonnée [(0,0)] en bas à
    gauche).
    [dim_x] (resp. [dim_y]) représente le nombre de pixel horizontaux
    (resp. verticaux) d'une case du plateau de jeu.
    [nb_col] (resp. [nb_lig]) représente le nombre de cases sur une colonne
    (resp. une ligne) du plateau de jeu. *)
