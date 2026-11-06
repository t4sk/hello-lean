/-
# Tail recursion

A recursive call is in *tail position* when its result is returned
immediately. Tail calls can be compiled to loops. Accumulator arguments
are the usual way to make a function tail-recursive.
-/
import Std

/-! ## Accumulators -/

def sumAcc (acc : Nat) : List Nat → Nat
  | [] => acc
  | x :: xs => sumAcc (acc + x) xs

def sumWithAcc (xs : List Nat) : Nat :=
  sumAcc 0 xs

#eval sumWithAcc (List.range 1000)

def reverseAcc (acc : List α) : List α → List α
  | [] => acc
  | x :: xs => reverseAcc (x :: acc) xs

def reverse' (xs : List α) : List α :=
  reverseAcc [] xs

#eval reverse' [1, 2, 3, 4]

/-! ## Fibonacci with a pair of accumulators -/

def fibAux (n : Nat) (a b : Nat) : Nat :=
  match n with
  | 0 => a
  | n + 1 => fibAux n b (a + b)

def fibTail (n : Nat) : Nat :=
  fibAux n 0 1

#eval fibTail 10
#eval fibTail 30

/-! ## `foldl` versus `foldr` -/

#eval [1, 2, 3].foldl (· - ·) 0
#eval [1, 2, 3].foldr (· - ·) 0

/-! ## A tail-recursive map -/

def mapAcc (f : α → β) (acc : List β) : List α → List β
  | [] => acc.reverse
  | x :: xs => mapAcc f (f x :: acc) xs

def map' (f : α → β) (xs : List α) : List β :=
  mapAcc f [] xs

#eval map' (· * 2) [1, 2, 3, 4]
