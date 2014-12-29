(*
 * $File$
 * $Author$
 * $Date$
 * $Revision$
 *)

fun to_nat_0 x =
let
  val n = Real.toInt IEEEReal.TO_NEAREST x
in
  if Real.== (Real.fromInt n, Real.abs x) then SOME n else NONE
end

fun penta n =
  n*(3*n-1) div 2

fun inv_penta (x: int) =
  to_nat_0 (((Math.sqrt o Real.fromInt) (24*x+1) + 1.0)/6.0)

fun floor_penta (x: int) =
  Real.floor (((Math.sqrt o Real.fromInt) (24*x+1) + 1.0)/6.0)

(*
 * bruteforce
 *)
fun search n =
let
  fun search n x =
    if (Option.isSome o inv_penta) (penta n + penta x) andalso
       (Option.isSome o inv_penta) (penta n + 2 * penta x)
    then (n, x)
    else  search n (x+1)
    handle Overflow => (print (Int.toString (n+1) ^ "\n"); search (n+1) 1)
  in
    search n 1
end

val _ =
let
  val (n,m) = search 1 (* 1900 *)
in
  print "Found " ;
  (print o Int.toString) n ;
  print " " ;
  (print o Int.toString) m ;
  print "\n"
end

