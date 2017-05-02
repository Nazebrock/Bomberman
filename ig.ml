# 1 "leximages.mll"
  
  open Lexing
  
  exception Erreur of string
  exception Fichier_non_trouve of string

  let transp = Graphics.rgb 255 255 255

# 11 "leximages.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base = 
   "\000\000\252\255\251\255\001\000\002\000\010\000\036\000\062\000\
    \072\000\098\000\124\000\004\000\003\000\254\255\001\000\004\000\
    \253\255\005\000\255\255";
  Lexing.lex_backtrk = 
   "\255\255\255\255\255\255\000\000\004\000\004\000\255\255\255\255\
    \255\255\255\255\255\255\002\000\255\255\255\255\255\255\001\000\
    \255\255\255\255\255\255";
  Lexing.lex_default = 
   "\002\000\000\000\000\000\255\255\012\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\012\000\000\000\015\000\017\000\
    \000\000\018\000\000\000";
  Lexing.lex_trans = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\003\000\003\000\013\000\013\000\011\000\000\000\
    \000\000\000\000\000\000\000\000\007\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \003\000\003\000\000\000\004\000\011\000\000\000\000\000\000\000\
    \000\000\000\000\007\000\000\000\000\000\000\000\007\000\000\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\006\000\006\000\006\000\006\000\006\000\006\000\
    \006\000\006\000\006\000\006\000\007\000\000\000\000\000\000\000\
    \007\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \004\000\000\000\009\000\000\000\006\000\006\000\006\000\006\000\
    \006\000\006\000\006\000\006\000\006\000\006\000\007\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \009\000\000\000\000\000\000\000\009\000\000\000\008\000\008\000\
    \008\000\008\000\008\000\008\000\008\000\008\000\008\000\008\000\
    \008\000\008\000\008\000\008\000\008\000\008\000\008\000\008\000\
    \008\000\008\000\009\000\000\000\000\000\000\000\011\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\011\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\010\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \001\000\016\000\255\255\255\255\255\255\255\255\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000";
  Lexing.lex_check = 
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\000\000\003\000\004\000\012\000\011\000\255\255\
    \255\255\255\255\255\255\255\255\005\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\003\000\255\255\000\000\011\000\255\255\255\255\255\255\
    \255\255\255\255\005\000\255\255\255\255\255\255\006\000\255\255\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\006\000\255\255\255\255\255\255\
    \007\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\008\000\255\255\006\000\006\000\006\000\006\000\
    \006\000\006\000\006\000\006\000\006\000\006\000\007\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \008\000\255\255\255\255\255\255\009\000\255\255\007\000\007\000\
    \007\000\007\000\007\000\007\000\007\000\007\000\007\000\007\000\
    \008\000\008\000\008\000\008\000\008\000\008\000\008\000\008\000\
    \008\000\008\000\009\000\255\255\255\255\255\255\010\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\009\000\009\000\009\000\009\000\009\000\009\000\
    \009\000\009\000\009\000\009\000\010\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\010\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\014\000\004\000\012\000\015\000\017\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255";
  Lexing.lex_base_code = 
   "\000\000\000\000\000\000\000\000\000\000\010\000\036\000\062\000\
    \025\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000";
  Lexing.lex_backtrk_code = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\010\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000";
  Lexing.lex_default_code = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000";
  Lexing.lex_trans_code = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\004\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\004\000\000\000\000\000\000\000\004\000\000\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\004\000\000\000\000\000\000\000\
    \004\000\007\000\007\000\007\000\007\000\007\000\007\000\007\000\
    \007\000\007\000\007\000\000\000\001\000\001\000\001\000\001\000\
    \001\000\001\000\001\000\001\000\001\000\001\000\004\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\007\000\007\000\
    \007\000\007\000\007\000\007\000\007\000\007\000\007\000\007\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000";
  Lexing.lex_check_code = 
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\005\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\005\000\255\255\255\255\255\255\006\000\255\255\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\006\000\255\255\255\255\255\255\
    \007\000\008\000\008\000\008\000\008\000\008\000\008\000\008\000\
    \008\000\008\000\008\000\255\255\006\000\006\000\006\000\006\000\
    \006\000\006\000\006\000\006\000\006\000\006\000\007\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\007\000\007\000\
    \007\000\007\000\007\000\007\000\007\000\007\000\007\000\007\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255";
  Lexing.lex_code = 
   "\255\003\255\255\004\255\255\005\255\255\000\003\002\005\001\004\
    \255";
}

let rec preambule lexbuf =
  lexbuf.Lexing.lex_mem <- Array.make 6 (-1) ;   __ocaml_lex_preambule_rec lexbuf 0
and __ocaml_lex_preambule_rec lexbuf __ocaml_lex_state =
  match Lexing.new_engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 14 "leximages.mll"
                            ( preambule lexbuf )
# 229 "leximages.ml"

  | 1 ->
# 15 "leximages.mll"
                            ( preambule lexbuf )
# 234 "leximages.ml"

  | 2 ->

  let x = Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_mem.(0)
  and y = Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_mem.(1) lexbuf.Lexing.lex_mem.(2) in
# 17 "leximages.mll"
         ( int_of_string x , int_of_string y )
# 242 "leximages.ml"

  | 3 ->
# 18 "leximages.mll"
         ( raise (Erreur "Préambule incomplet"))
# 247 "leximages.ml"

  | 4 ->
# 19 "leximages.mll"
         ( raise (Erreur "EndOfFile lors du préambule"))
# 252 "leximages.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; __ocaml_lex_preambule_rec lexbuf __ocaml_lex_state

and rgb lexbuf =
    __ocaml_lex_rgb_rec lexbuf 14
and __ocaml_lex_rgb_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->

  let c1 = Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos
  and c2 = Lexing.sub_lexeme_char lexbuf (lexbuf.Lexing.lex_start_pos + 1)
  and c3 = Lexing.sub_lexeme_char lexbuf (lexbuf.Lexing.lex_start_pos + 2) in
# 23 "leximages.mll"
        ( Graphics.rgb (int_of_char c1) (int_of_char c2) (int_of_char c3) )
# 267 "leximages.ml"

  | 1 ->
# 24 "leximages.mll"
        ( raise (Erreur "Triplet incomplet"))
# 272 "leximages.ml"

  | 2 ->
# 25 "leximages.mll"
        ( raise (Erreur "EndOfFile lors d'un rgb"))
# 277 "leximages.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; __ocaml_lex_rgb_rec lexbuf __ocaml_lex_state

;;

# 27 "leximages.mll"
  
  let convertir img = 
    try
      let f = open_in ("images/"^img) in
      let buf = Lexing.from_channel f in
      let x,y = preambule buf in
      let img = Array.make_matrix y x (Graphics.rgb 0 0 0) in 
      for i = 0 to y-1 do
	for j = 0 to x-1 do
	  let coul = rgb buf in
	  if coul = transp then 
	    img.(i).(j) <- Graphics.transp
	  else img.(i).(j) <- coul;
	done
      done;
      close_in f;
      img , x , y
    with Sys_error _ -> 
      raise (Fichier_non_trouve ("images/"^img))

# 304 "leximages.ml"
open Graphics
open Gtypes

(* Quelques constantes graphiques *)

let cellule_size_x = ref 0
let cellule_size_y = ref 0

let robot_size_x = ref 0
let robot_size_y = ref 0
let bombe_size_x = ref 0
let bombe_size_y = ref 0

let decalage_bombe_x = ref 0
let decalage_bombe_y = ref 0

let decalage_robot_x = ref 0
let decalage_robot_y = ref 0

let nb_pas_par_robot = 4
let nb_images_par_bombe = 16

(* Fonctions de conversion *)

let coord_of_case i j = i * !cellule_size_x , j * !cellule_size_y

(* Initialisation des images *)

let gris = rgb 200 200 200

(* on est obligé d'utiliser un Obj.magic car il faut ouvrir une
   fenêtre graphique pour créer des valeurs de type image *)
let image_vide = Obj.magic () 
let brique = ref image_vide
let extra = ref image_vide
let extra_brise = ref image_vide
let robot_mort = ref image_vide
let bombes = Array.init nb_images_par_bombe (fun _->image_vide)
let explosions : (forme_flamme,image) Hashtbl.t = Hashtbl.create 19
let robots : ((couleur*direction),image array) Hashtbl.t = Hashtbl.create 13
let robots_grilles : (couleur,image) Hashtbl.t = Hashtbl.create 3

(* Fonctions d'affichage *)

let affiche_sol i j =
  let x , y = coord_of_case i j in
  set_color gris; fill_rect x y (!cellule_size_x) (!cellule_size_y)


exception Erreur_Graphique of string

let affiche_sprite = function
    Bomberman ({etat=Vivant;couleur=c;dir=d;pas=p} as r) -> 
      let x = r.x - !decalage_robot_x in
      let y = r.y - !decalage_robot_y in
      (try 
	 match p with
	     None -> draw_image (Hashtbl.find robots (c,d)).(0) x y
	   | Some i -> draw_image (Hashtbl.find robots (c,d)).(i) x y
       with Not_found -> raise (Erreur_Graphique "Numéro de pas inconnu"))
  | Bomberman ({etat=Grille;couleur=c} as r) -> 
      let x = r.x - !decalage_robot_x in
      let y = r.y - !decalage_robot_y in
      draw_image (Hashtbl.find robots_grilles c) x y
  | Bomberman ({etat=Mort} as r) -> 
      let x = r.x - !decalage_robot_x in
      let y = r.y - !decalage_robot_y in
      draw_image !robot_mort x y
  | Flamme ({f_forme=forme} as f) -> 
      let x , y = coord_of_case f.f_i f.f_j in
      draw_image (Hashtbl.find explosions forme) x y
  | Bloc {blk_forme=Cassable(Intact);blk_i=i;blk_j=j} -> 
      let x , y = coord_of_case i j in draw_image !extra x y
  | Bloc {blk_forme=Cassable(Brise); blk_i=i;blk_j=j} -> 
      let x , y = coord_of_case i j in draw_image !extra_brise x y
  | Bombe ({b_duree=n} as b) -> 
      let x , y = coord_of_case b.b_i b.b_j in 
      let x' = x + !decalage_bombe_x in
      let y' = y + !decalage_bombe_y in
      (try
	 draw_image (bombes).(n) x' y'
       with Invalid_argument "index out of bounds" ->
	 raise (Erreur_Graphique "Numéro de bombe incorrect"))
  | Bloc {blk_forme=Incassable;blk_i=i;blk_j=j} ->
      let x , y = coord_of_case i j in draw_image !brique x y
  | Sol(i,j) -> affiche_sol i j

let affiche_sol_robot x y = 
  let x' = x - (!robot_size_x / 2) in
  let y' = y - (!robot_size_y / 2) in
  set_color gris; fill_rect x' y' !robot_size_x !robot_size_y

let efface_sprite = function
    Bomberman {x=x;y=y} -> affiche_sol_robot x y
  | Flamme {f_i=i;f_j=j} -> affiche_sol i j
  | Bombe {b_i=i;b_j=j} -> affiche_sol i j
  | Bloc {blk_i=i;blk_j=j} -> affiche_sol i j
  | Sol(i,j) -> affiche_sol i j


(* Renommage de quelques fonctions de Graphics *)

let affiche = synchronize 
let touche_pressee =  Graphics.key_pressed
let lecture_touche = Graphics.read_key

(* Initialisation de l'interface graphique *)

let init_bombes () = 
  let image_of n = 
    let img , x , y = 
      convertir ("bombes/bomb_"^(string_of_int n)^".ppm") 
    in 
    bombe_size_x := x;
    bombe_size_y := y;
    make_image img
  in
  for i=0 to nb_images_par_bombe-1 do
    bombes.(i) <- image_of i
  done

let init_explosions () = 
  let image_of img = 
    let i , _ , _ = convertir ("bombes/expl"^img^".ppm") in 
    make_image i 
  in
  Hashtbl.replace explosions FGauche (image_of "G");
  Hashtbl.replace explosions FDroite (image_of "D");
  Hashtbl.replace explosions FHaut (image_of "H");
  Hashtbl.replace explosions FBas (image_of "B");
  Hashtbl.replace explosions FCroix (image_of "GDHB");
  Hashtbl.replace explosions FHoriz (image_of "GD");
  Hashtbl.replace explosions FVert (image_of "HB")

let init_robots () = 
  let image_of img n = 
    let i , x , y = convertir (img^(string_of_int n)^".ppm") in 
    robot_size_x := x;
    robot_size_y := y;
    make_image i 
  in
  Hashtbl.replace robots (Bleu,Ouest) 
    (Array.init nb_pas_par_robot (image_of "bleu/G"));
  Hashtbl.replace robots (Bleu,Est) 
    (Array.init nb_pas_par_robot (image_of "bleu/D"));
  Hashtbl.replace robots (Bleu,Nord)
    (Array.init nb_pas_par_robot (image_of "bleu/H"));
  Hashtbl.replace robots (Bleu,Sud)
    (Array.init nb_pas_par_robot (image_of "bleu/B"));

  Hashtbl.replace robots (Vert,Ouest)
    (Array.init nb_pas_par_robot (image_of "vert/G"));
  Hashtbl.replace robots (Vert,Est)
    (Array.init nb_pas_par_robot (image_of "vert/D"));
  Hashtbl.replace robots (Vert,Nord)
    (Array.init nb_pas_par_robot (image_of "vert/H"));
  Hashtbl.replace robots (Vert,Sud)
    (Array.init nb_pas_par_robot (image_of "vert/B"));

  Hashtbl.replace robots (Violet,Ouest) 
    (Array.init nb_pas_par_robot (image_of "violet/G"));
  Hashtbl.replace robots (Violet,Est) 
    (Array.init nb_pas_par_robot (image_of "violet/D"));
  Hashtbl.replace robots (Violet,Nord)
    (Array.init nb_pas_par_robot (image_of "violet/H"));
  Hashtbl.replace robots (Violet,Sud)
    (Array.init nb_pas_par_robot (image_of "violet/B"));

  Hashtbl.replace robots (Rouge,Ouest)
    (Array.init nb_pas_par_robot (image_of "rouge/G"));
  Hashtbl.replace robots (Rouge,Est)
    (Array.init nb_pas_par_robot (image_of "rouge/D"));
  Hashtbl.replace robots (Rouge,Nord)
    (Array.init nb_pas_par_robot (image_of "rouge/H"));
  Hashtbl.replace robots (Rouge,Sud)
    (Array.init nb_pas_par_robot (image_of "rouge/B"));

  let bleu_grille , _ , _ = convertir "bleu/Grille.ppm" in
  let vert_grille , _ , _ = convertir "vert/Grille.ppm" in
  let violet_grille , _ , _ = convertir "violet/Grille.ppm" in
  let rouge_grille , _ , _ = convertir "rouge/Grille.ppm" in

  let mort , _ , _ = convertir "mort.ppm" in
  Hashtbl.replace robots_grilles Bleu (make_image bleu_grille);
  Hashtbl.replace robots_grilles Vert (make_image vert_grille);
  Hashtbl.replace robots_grilles Violet (make_image violet_grille);
  Hashtbl.replace robots_grilles Rouge (make_image rouge_grille);
  robot_mort := (make_image mort)

let init_fond () = 
  let img ,  xbrk , ybrk = convertir "floor/brique.ppm" in
  if !cellule_size_x <> xbrk || !cellule_size_y <> ybrk then
    raise (Erreur_Graphique "brique.ppm: dimensions incorrectes!");
  brique := (make_image img);
  let img ,  xbrk , ybrk = convertir "floor/extra.ppm" in
  if !cellule_size_x <> xbrk || !cellule_size_y <> ybrk then
    raise (Erreur_Graphique "extra.ppm: dimensions incorrectes!");
  extra := (make_image img);
  let img ,  xbrk , ybrk = convertir "floor/extra_O.ppm" in
  if !cellule_size_x <> xbrk || !cellule_size_y <> ybrk then
    raise (Erreur_Graphique "extra_O.ppm: dimensions incorrectes!");
  extra_brise := (make_image img)

let init dimx dimy nbc nbl= 
  close_graph();
  cellule_size_x := dimx;
  cellule_size_y := dimy;
  let dx = string_of_int (dimx*nbc) in
  let dy = string_of_int (dimy*nbl) in
  open_graph (" "^dx^"x"^dy);
  set_color gris; 
  fill_rect 0 0 (dimx*nbc) (dimy*nbl);
  try
    init_fond();
    init_bombes ();
    init_explosions ();
    init_robots ();
    decalage_bombe_x := (!cellule_size_x - !bombe_size_x) / 2 ;
    decalage_bombe_y := (!cellule_size_y - !bombe_size_y) / 2 ;
    decalage_robot_x :=  !robot_size_x / 2;
    decalage_robot_y :=  !robot_size_y / 2;
    auto_synchronize false
  with Fichier_non_trouve s -> 
    raise (Erreur_Graphique ("impossible de charger les images "^s))
