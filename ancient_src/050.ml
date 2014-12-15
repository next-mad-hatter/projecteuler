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
  in sieve_rec 3 (Array.make n false) [2]

let lim = 1000000

let primes = primes_upto lim

let len p =
  (*print_endline (string_of_int p);*)
  let ps = Array.of_list (List.filter (fun x -> (x <= p/2)) primes) in
  let rec best m start stop sum =
    if sum < p then
      if start = 0 then m
      else best m (start-1) stop (sum + Array.get ps (start-1))
    else begin
      let m = (if sum = p then (max m (stop - start + 1)) else m) in
      if stop = 0 then m
      else best m (stop-1) (stop-1) (Array.get ps (stop-1))
    end
  in
  best 1 ((Array.length ps) - 1)
         ((Array.length ps) - 1)
         (Array.get ps ((Array.length ps) - 1 ))

(* better mayby top down and break when available less than already best *)
let sol =
  let l = List.filter (fun x -> x >= 953) primes in
  let rec best m nums =
    match nums with x::xs -> begin
      let l = len x in
      let m = if (fst m) < l then begin
        print_int l; print_string " "; print_int x; print_endline "";
        (l,x)
      end
      else m in
      best m xs
    end
    | _ -> m
  in
  best (21,953) l
