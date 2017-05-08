(** Types utilis�s par l'interface graphique. *)

(** Un bomberman peut se d�placer dans 4 directions. *)
type direction = | Ouest | Est | Nord | Sud

(** Le jeu est limit� � 4 bombermen de couleur [Bleu], [Vert], [Rouge] et 
  [Violet]. *)
type couleur = Bleu | Vert | Rouge | Violet

(** Les 3 �tats possibles pour un bomberman: [Vivant], [Grille] par une flamme
  et d�finitivement [Mort]. *) 
type etat_bomberman = Vivant | Grille | Mort

(** Le type des sprites repr�sentant les bombermen. *)
type bomberman = {
  x : int;                  (** Abscisse dans la fen�tre graphique *)
  y : int;                  (** Ordonn�e dans la fen�tre graphique *)
  couleur : couleur;        (** Couleur du bomberman *)
  dir     : direction;      (** Direction *)
  etat    : etat_bomberman; (** �tat      *)
  pas     : int option      (** Entier repr�sentant l'image du pas du 
			      bomberman *)
}

(** Les diff�rents types d'image d'une flamme. *) 
type forme_flamme = 
  | FGauche    (** Flamme vers la gauche *)
  | FDroite    (** Flamme vers la droite *)
  | FBas       (** Flamme vers le bas    *)
  | FHaut      (** Flamme vers le haut   *)
  | FVert      (** Flamme verticale      *)
  | FHoriz     (** Flamme horizontale    *)
  | FCroix     (** Flamme en croix (juste apr�s l'explosion) *)

(** Le type des sprites repr�sentant les flammes. *)
type flamme = { 
  f_i : int;     (** Abscisse de la case dans laquelle se trouve le sprite *)
  f_j : int;     (** Ordonn�e de la case dans laquelle se trouve le sprite *)
  f_forme : forme_flamme (** Forme de la flamme *)
}

(** Le type des sprites repr�sentant les bombes. *)
type bombe = { 
  b_i : int ;    (** Abscisse de la case dans laquelle se trouve le sprite *)
  b_j : int ;    (** Ordonn�e de la case dans laquelle se trouve le sprite *)
  b_duree : int  (** Dur�e depuis laquelle la bombe est active:
		   repr�sente l'image de la bombe � afficher *)
}

(** Les blocs d'un plateau de jeu peuvent �tre [Incassable]s ou
  [Cassable]s. Quand elle sont cassables, elles peuvent se trouver dans
  l'�tat [Intact] ou [Brise] *)

type etat_bloc_cassable = Intact | Brise
type forme_bloc = Incassable | Cassable of etat_bloc_cassable

(** Le type des sprites repr�sentant les blocs (ou briques) du plateau. *)
type bloc = {
  blk_i : int;   (** Abscisse de la case dans laquelle se trouve le sprite *)
  blk_j : int;   (** Ordonn�e de la case dans laquelle se trouve le sprite *)
  blk_forme : forme_bloc (** Forme du bloc. *)
}

(** Le type de tous les sprites d'un plateau de jeu. *)
type sprite = 
    Bomberman of bomberman  (** Bomberman *)
  | Flamme of flamme        (** Flamme    *)
  | Bombe of bombe          (** Bombe     *)
  | Bloc of bloc            (** Bloc      *)
  | Sol of int * int        (** Case vide � la position indiqu�e *)

(** Le type d'action a effectuer sur le sprite *)
type action_sprite =        
      Affiche of sprite     (** Sprite a afficher *)
    | Efface of sprite      (** Sprite a effacer *)
    | Refresh of sprite     (** Sprite a rafraichir *)
    | Fin of bool           (** Fin de partie *)
