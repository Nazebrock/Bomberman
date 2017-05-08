(** Types utilisés par l'interface graphique. *)

(** Un bomberman peut se déplacer dans 4 directions. *)
type direction = | Ouest | Est | Nord | Sud

(** Le jeu est limité à 4 bombermen de couleur [Bleu], [Vert], [Rouge] et 
  [Violet]. *)
type couleur = Bleu | Vert | Rouge | Violet

(** Les 3 états possibles pour un bomberman: [Vivant], [Grille] par une flamme
  et définitivement [Mort]. *) 
type etat_bomberman = Vivant | Grille | Mort

(** Le type des sprites représentant les bombermen. *)
type bomberman = {
  x : int;                  (** Abscisse dans la fenêtre graphique *)
  y : int;                  (** Ordonnée dans la fenêtre graphique *)
  couleur : couleur;        (** Couleur du bomberman *)
  dir     : direction;      (** Direction *)
  etat    : etat_bomberman; (** État      *)
  pas     : int option      (** Entier représentant l'image du pas du 
			      bomberman *)
}

(** Les différents types d'image d'une flamme. *) 
type forme_flamme = 
  | FGauche    (** Flamme vers la gauche *)
  | FDroite    (** Flamme vers la droite *)
  | FBas       (** Flamme vers le bas    *)
  | FHaut      (** Flamme vers le haut   *)
  | FVert      (** Flamme verticale      *)
  | FHoriz     (** Flamme horizontale    *)
  | FCroix     (** Flamme en croix (juste après l'explosion) *)

(** Le type des sprites représentant les flammes. *)
type flamme = { 
  f_i : int;     (** Abscisse de la case dans laquelle se trouve le sprite *)
  f_j : int;     (** Ordonnée de la case dans laquelle se trouve le sprite *)
  f_forme : forme_flamme (** Forme de la flamme *)
}

(** Le type des sprites représentant les bombes. *)
type bombe = { 
  b_i : int ;    (** Abscisse de la case dans laquelle se trouve le sprite *)
  b_j : int ;    (** Ordonnée de la case dans laquelle se trouve le sprite *)
  b_duree : int  (** Durée depuis laquelle la bombe est active:
		   représente l'image de la bombe à afficher *)
}

(** Les blocs d'un plateau de jeu peuvent être [Incassable]s ou
  [Cassable]s. Quand elle sont cassables, elles peuvent se trouver dans
  l'état [Intact] ou [Brise] *)

type etat_bloc_cassable = Intact | Brise
type forme_bloc = Incassable | Cassable of etat_bloc_cassable

(** Le type des sprites représentant les blocs (ou briques) du plateau. *)
type bloc = {
  blk_i : int;   (** Abscisse de la case dans laquelle se trouve le sprite *)
  blk_j : int;   (** Ordonnée de la case dans laquelle se trouve le sprite *)
  blk_forme : forme_bloc (** Forme du bloc. *)
}

(** Le type de tous les sprites d'un plateau de jeu. *)
type sprite = 
    Bomberman of bomberman  (** Bomberman *)
  | Flamme of flamme        (** Flamme    *)
  | Bombe of bombe          (** Bombe     *)
  | Bloc of bloc            (** Bloc      *)
  | Sol of int * int        (** Case vide à la position indiquée *)

(** Le type d'action a effectuer sur le sprite *)
type action_sprite =        
      Affiche of sprite     (** Sprite a afficher *)
    | Efface of sprite      (** Sprite a effacer *)
    | Refresh of sprite     (** Sprite a rafraichir *)
    | Fin of bool           (** Fin de partie *)
