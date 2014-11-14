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

let prime x =
  let rec iterate p x =
    if x mod p = 0 then false
    else if float_of_int(p) > sqrt(float_of_int(x)) then true
    else iterate (p+1) x
  in
  if x = 2 then true
  else if x < 2 then false
  else iterate 2 x

let str_of_list x =
  let x = List.map string_of_int x in
  List.fold_left (^) "" x

let strs numbers =
  List.map (fun x -> int_of_string(str_of_list(x))) numbers

let numbers =
  let x = List.filter prime (strs(permutations 7)) in
  List.fold_left (max) 0 (x)

let strs =
  List.map str_of_list numbers

