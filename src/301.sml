(*
 * $File$
 * $Author$
 * $Date$
 * $Revision$
 *)

(*
 * Bruter than brute, but fast enough :)
 *)

val m = valOf (IntInf.fromString "1073741824")

fun iter n count =
  if n > m then count
  else if foldl IntInf.xorb (IntInf.fromInt 0) [n, 2*n, 3*n] = 0 then iter (n+1) (count+1)
  else iter (n+1) count

val _ =
  print ((Int.toString (iter 1 0)) ^ "\n")

