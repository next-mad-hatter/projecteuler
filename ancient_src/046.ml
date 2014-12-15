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

let primes = primes_upto Sys.max_array_length

let sat x =
  (*
  if x mod 1000 = 1 then begin
    print_int x; print_endline "";
  end;
  *)
  let ps = primes_upto (x+1) in
  let rec satr ps x =
    if List.mem x ps then true
    else match ps with
      [] -> false
    | p::px -> begin
      if p >= x then false
      else begin
        let d = x - p in
        let r = d / 2 in
        let s = int_of_float (sqrt (float_of_int r)) in
        if (r>0) && (p + s * s * 2 = x) then true
        else satr px x
      end
    end
  in satr ps x

let rec search x =
  if not (sat x) then x
  else search (x+2)

let _ =
  let res = search 33 in
  print_int res;
  print_endline ""

