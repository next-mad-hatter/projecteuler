(*
(* exchange into l @ [x] @ accu x with the last element of l which is > x *)
let rec swap l x accu = match l with
| a::b::t when b > x -> a :: (swap (b::t) x accu)
| a::t -> (x::t) @ (a::accu)
| _ -> failwith "this can't happen"

(* permut l m accu computes the permutation p' following p = rev(l)@m,
stores it into accu and recalls itself until p has no successor *)
let rec permut l m accu = match l,m with
| a::_, b::t when a > b -> let p = swap l b t in permut [] p (p::accu)
| _, b::t -> permut (b::l) t accu
| _, [] -> accu

(* build x n accu returns [n; ...; x] @ accu *)
let rec build x n accu = if x>n then accu else build (x+1) n (x::accu)

(* permutations n returns the list of all permutations of 1..n *)
let permutations n =
  let p = build 1 n [] in permut [] p [p]

let str_of_list x =
  let x = List.map string_of_int x in
  List.fold_left (^) "" x

let strs numbers =
  List.map (fun x -> str_of_list(x)) numbers

let divisible str (a,b,c) x =
  let a = String.sub str a 1 in
  let b = String.sub str b 1 in
  let c = String.sub str c 1 in
  int_of_string(c ^ b ^ a) mod x = 0

let sat str =
  divisible str (3,2,1) 2 &&
  divisible str (4,3,2) 3 &&
  divisible str (5,4,3) 5 &&
  divisible str (6,5,4) 7 &&
  divisible str (7,6,5) 11 &&
  divisible str (8,7,6) 13 &&
  divisible str (9,8,7) 17

let numbers =
  strs(permutations 9)
  (*List.filter sat (strs(permutations 9))*)

(*
let strs =
  List.map str_of_list numbers
*)

*)

(* makes a list unique *)
let unique l = List.rev (List.fold_left (
  fun results x -> if List.mem x results then results else x::results)
  [] l);;

(* splits a number into digits *)
let split num =
  let rec split_r num =
    if num < 10 then [num]
    else (split_r (num/10) @ [num mod 10])
  in
  let l = split_r num in
  if List.length l = 2 then 0::l
  else if List.length l = 1 then [0;0] @ l
  else l

(* checks if a number contains its digits not more than once *)
let pan x =
  let rec panr built x =
    if x < 10 then
      not (List.mem x built)
    else begin
      let d = x mod 10 in
      if List.mem d built then false
      else panr (d::built) (x/10)
    end
  in
  panr [] x

(* computes "unique" multiples of a given number, then splits them *)
let multis x =
  let rec mult x n res =
    let n = (n+1) in
    if x * n > 999 then res
    else
      let res = if pan(x*n) then (x*n)::res else res in
      mult x n res
  in
  List.map split (mult x 0 [])

(* concatenates two sequences *)
let concat x y =
  match y with
  y1::y2::ys -> x @ ys
  | _ -> failwith "error error"

(* checks if two sequences can be concatenated *)
let sat x y =
  match x with
  x1::x2::x3::xs -> begin
    match y with
    y1::y2::ys -> begin
      (x2 = y1) &&
      (x3 = y2) &&
      (List.length (unique (x @ ys) ) = List.length (x @ ys))
    end
    | [] | _ -> failwith "error error"
  end
  |  _ -> failwith "error error"

(* finds all sequences from two lists *)
let combine a b =
  (* finds all sequences from list l for suffix x *)
  let seqs l x =
    let rec con acc l x =
      match l with
        [] -> acc
      | y::ys -> con (if (sat y x) then ((concat y x)::acc) else acc) ys x
    in
    con [] l x
  in
  List.flatten (List.map (fun x -> seqs a x) b)

let x =
  let a1 = combine (multis 13) (multis 17) in
  let a2 = combine (multis 11) a1 in
  let a3 = combine (multis 7) a2 in
  let a4 = combine (multis 5) a3 in
  let a5 = combine (multis 3) a4 in
  let a6 = combine (multis 2) a5 in
  a6

(* this gives us
4130952867 + 1430952867 + 4160357289 + 1460357289 + 4106357289 + 1406357289
*)
