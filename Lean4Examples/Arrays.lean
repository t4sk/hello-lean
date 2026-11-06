/-
# Arrays

Arrays are efficient, contiguous sequences. Their API is functional:
operations return new arrays rather than mutating in place, although the
compiler can often optimize updates.
-/
import Std

def arr : Array Nat :=
  #[1, 2, 3, 4]

#eval arr
#eval arr.size
#eval arr[1]!
#eval arr.push 5
#eval arr.set! 0 10
#eval arr.map (· * 2)
#eval arr.foldl (fun acc x => acc + x) 0
#eval arr.reverse
#eval arr.toList
#eval Array.range 5
#eval arr.extract 1 3

/-! ## Building arrays -/

#eval (Array.mkEmpty 4).push 1 |>.push 2 |>.push 3

def squaresUpTo (n : Nat) : Array Nat :=
  (Array.range (n + 1)).map (fun x => x * x)

#eval squaresUpTo 5

/-! ## Indexing safely -/

def getOrElse (a : Array α) (i : Nat) (fallback : α) : α :=
  a[i]?.getD fallback

#eval getOrElse arr 2 0
#eval getOrElse arr 99 0

/-! ## A proof about `push` -/

example (a : Array Nat) (x : Nat) : (a.push x).size = a.size + 1 :=
  Array.size_push x
