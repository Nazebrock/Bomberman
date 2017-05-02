(** Ce fichier contient les primitives graphiques utiles pour le client du jeu 
  Bomberman. *)

val nb_pas_par_robot : int
  (** Nombre de pas d�composant la marche d'un robot. *)

val nb_images_par_bombe : int
  (** Nombre d'images repr�sentant le d�compte d'une bombe avant son
    explosion. *)

exception Erreur_Graphique of string

val affiche_sprite: Gtypes.sprite -> unit
  (** [affiche_sprite s] pr�pare l'affichage du sprite [s] dans la m�moire
    graphique : cette fonction ne modifie pas l'affichage sur l'�cran, 
    elle ne modifie que la m�moire.
    @raise Erreur_Graphique si l'image correspondant au sprite n'existe pas. *)

val efface_sprite : Gtypes.sprite -> unit
  (** [efface_sprite s] remplace le sprite [s] par un fond de couleur gris 
    dans la m�moire graphique : cette fonction ne modifie pas l'affichage sur 
    l'�cran, elle ne modifie que la m�moire. *)

val affiche: unit -> unit
  (** Affiche le contenu de la m�moire graphique � l'�cran. *)

val touche_pressee: unit -> bool 
  (** Indique si une touche a �t� press�e par l'utilisateur.
    Cette fonction n'est pas bloquante.
    @return [true] si une touche a �t� press�e, [false] sinon. *)

val lecture_touche: unit -> char
  (** Attend que l'utilisateur presse une touche.
    Cette fonction est donc bloquante.
    @return Le caract�re associ� � la touche press�e par l'utilisateur. *)

val init: int -> int -> int -> int -> unit
  (** [init dim_x dim_y nb_col nb_lig] ouvre une fen�tre graphique de dimension
    [(dim_x * nb_col) x (dim_y * nb_lig)] (avec la coordonn�e [(0,0)] en bas �
    gauche).
    [dim_x] (resp. [dim_y]) repr�sente le nombre de pixel horizontaux
    (resp. verticaux) d'une case du plateau de jeu.
    [nb_col] (resp. [nb_lig]) repr�sente le nombre de cases sur une colonne
    (resp. une ligne) du plateau de jeu. *)
