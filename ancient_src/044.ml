(* p-nums def: P(n) *)
let pent n =
  n*(3*n-1)/2

(* all P(n) in search range *)
let p_min_i = 2000
let p_max_i = 5000
let pents =
  let rec pentsr acc n =
    if n >= p_max_i then acc
    else begin
      let acc = acc @ [pent n] in
      let n = n+1 in
      pentsr acc n
    end
  in
  pentsr [] p_min_i

(* can this number be P(n+k) - P(n)? return (n+k,n) list *)
(* (naive search) *)
let diffs x =
  let x = 2*x in
  let f n k = k*(6*n+3*k-1) in
  let rec diffr acc n k =
    let r = f n k in
    let acc = if r = x then (n+k,n)::acc else acc in
    if r >= x && k = 1 then acc
    else begin
      if r < x then diffr acc n (k+1)
      else diffr acc (n+1) 1
    end
  in
  diffr [] 1 1

let sat x =
  let d = diffs x in
  let check y = if List.mem ((pent (fst y )) + (pent (snd y))) pents then true else false in
  List.length (List.filter (check) d) > 0

let _ = List.find (sat) pents
