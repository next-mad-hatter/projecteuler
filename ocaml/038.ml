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

let lim = [1;8;2;7;3;6;4;5]

let numbers =
  let x = permutations 8 in
  let x = List.filter (fun x -> ((compare x lim)) >= 0) x in
  let x = List.map (fun x -> 9 :: x) x in
  List.rev (List.sort compare (x))

let str_of_list x =
  let x = List.map string_of_int x in
  List.fold_left (^) "" x

let strs =
  List.map str_of_list numbers

(* why it fails for certain (non-relevant) strings?.. *)
let pandigital num =
  let rec sat num first =
    let rec pan num first built n =
      if first = "" then false else begin
        let add = (int_of_string first) * n in
        let built = built ^ string_of_int add in
        if built = num then true
        else if String.length built >= String.length num then false
        else pan num first built (n+1)
      end
    in
    let check = pan num first "" 1 in
    if check then true
    else begin
      if (String.length first + 1) = String.length num  then false
      else begin
        let next = String.sub num 0 ((String.length first) + 1) in
        sat num next
      end
    end
  in
  sat num ""

let best = List.find pandigital strs

let _ =
  print_int (List.length numbers);
  print_endline "";
  print_endline best;
