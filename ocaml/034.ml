(*#load "nums.cma";;
open Num;;

let rec fact n =
  if n =/ Int 0 then Int 1 else n */ fact(n -/ Int 1);;
*)

(* could be cached *)
let rec fact n =
  if n = 0 then 1 else n * fact(n - 1);;

let rec digits x =
  let y = x / 10 in
  if y = 0 then [x]
  else (x mod 10) :: digits y

let sat x =
  List.fold_left (+) 0 ( List.map fact (digits x) ) = x

(* could use a break condition *)
let max = 9999999

let rec iter s i max =
  let i = i+1 in
  if i > max then s else
  if sat(i) then iter (s+i) i max
  else iter s i max

let _ = print_int (iter 0 8 max)

