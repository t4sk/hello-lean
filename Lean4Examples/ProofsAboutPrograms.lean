/-
# Proofs about programs

Functional programs are definitions, so their properties can be proved by
induction and rewriting just like any other mathematical statement.
-/
import Std

namespace ProgramProofs

/-! ## Sum of a list -/

def sum : List Nat → Nat
  | [] => 0
  | x :: xs => x + sum xs

theorem sum_append (xs ys : List Nat) :
    sum (xs ++ ys) = sum xs + sum ys := by
  induction xs with
  | nil => simp [sum]
  | cons x xs ih =>
    simp [sum, ih]
    omega

theorem sum_replicate (n : Nat) (x : Nat) :
    sum (List.replicate n x) = n * x := by
  induction n with
  | zero => simp [sum]
  | succ n ih =>
    simp [List.replicate, sum, ih, Nat.succ_mul]
    omega

/-! ## Reversing a list -/

def reverse : List α → List α
  | [] => []
  | x :: xs => reverse xs ++ [x]

theorem reverse_append (xs ys : List α) :
    reverse (xs ++ ys) = reverse ys ++ reverse xs := by
  induction xs with
  | nil => simp [reverse]
  | cons x xs ih =>
    simp [reverse, ih, List.append_assoc]

theorem reverse_reverse (xs : List α) : reverse (reverse xs) = xs := by
  induction xs with
  | nil => rfl
  | cons x xs ih =>
    simp [reverse, reverse_append, ih]

/-! ## Factorial -/

def fact : Nat → Nat
  | 0 => 1
  | n + 1 => (n + 1) * fact n

theorem fact_pos (n : Nat) : fact n > 0 := by
  induction n with
  | zero => decide
  | succ n ih =>
    simp [fact]
    exact ih

theorem fact_succ (n : Nat) : fact (n + 1) = (n + 1) * fact n :=
  rfl

end ProgramProofs
