let exp a b =
  let rec aux x i =
    if i = b then x
    else aux (x * a) (i + 1)
  in
  aux 1 0

let sat a b c =
  exp a 2 + exp b 2 = exp c 2

let sol p =
  let rec sols acc p a b =
    let c = p-a-b in
    let acc = if sat a b c then acc+1 else acc in
    if a > p/2 then acc
    else if b > p/2 then sols acc p (a+1) (a+1)
    else sols acc p a (b+1)
  in
  sols 0 p 1 1

let best p =
  let rec iterate m v q =
    let x = sol q in
    let m = max m x in
    let v = if m = x then q else v in
    if q = p then v else iterate m v (q+1)
  in
  iterate 0 0 1

let p = 1000;;

print_endline (string_of_int (best p))

(*
let p = 120;;
print_endline (string_of_int (sol p));;

print_endline (string_of_bool (sat 20 48 52));;
print_endline (string_of_bool (sat 24 45 51));;
print_endline (string_of_bool (sat 30 40 50));;
*)
