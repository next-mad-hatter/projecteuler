(*
#load "nums.cma";;
open Num;;
*)

(*
let primes_upto n =
  let root = 1 + int_of_float (sqrt (float_of_int n)) in
  let rec sieve_rec i a prime_list =
    if i >= n then
      List.rev prime_list
    else
      sieve_rec (i + 2) (
        if i < root then
          let k = 2 * i in
          let rec rem_mult arr j =
            if j >= n then
              arr
            else
              rem_mult ((Array.set arr j true); arr) (k + j)
          in rem_mult a (i * i)
        else
          a
      ) (if (Array.get a i) = false then
    i :: prime_list
          else
        prime_list)
  in sieve_rec 3 (Array.make n false) [2];;
*)

let prime x =
  let rec iterate p x =
    if x mod p = 0 then false
    else if p > (x/2) then true
    else iterate (p+1) x
  in
  if x = 2 then true
  else if x < 2 then false
  else iterate 2 x

let rec length x =
  if x / 10 = 0 then 1
  else 1 + (length (x / 10))

let append a b =
  let i = length b in
  int_of_float ((float_of_int a) *. (10.0 ** (float_of_int i))) + b

let expand digits a =
  List.filter (fun x -> prime x) (
    (List.map (fun x -> append x a) digits)
  )

let next digits nums =
  List.flatten (List.map (fun x -> expand digits x) nums)

let proper x =
  let rec proper_r x =
    if x / 10 = 0 then prime x
    else prime x && proper_r (x/10)
  in
    (x > 10 && proper_r x)

let possible res x =
  if x >= 99999999 then false
  else if x < 2  then false
  else if x < 100 then true
  else let rec ends x =
    if x < 10 then [x]
    else x :: ends (x/10)
  in
  List.mem (x/10) (List.flatten (List.map ends res))

let all =
  let rec iterate res digits start =
    if start = [] then []
    else if List.length res > 10 then []
    else let res = res @ (List.filter proper start)  in
    let start = List.filter (possible (res @ start)) start in
    List.iter (fun x -> print_endline (string_of_int x)) res;
    print_endline "";
    iterate res digits (next digits start)
  in
  iterate [] [1; 2; 3; 5; 7; 9] [2; 3; 5; 7]

let _ = all
