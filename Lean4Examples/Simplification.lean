/-
# Simplification and rewriting

`simp` rewrites with a database of lemmas. You can add your own lemmas with
`@[simp]`, restrict the set with `simp only`, and pass local hypotheses.
-/
import Std

def double (n : Nat) : Nat :=
  n + n

@[simp] theorem double_zero_simp : double 0 = 0 := by
  simp [double]

@[simp] theorem double_succ_simp (n : Nat) : double (n + 1) = double n + 2 := by
  simp [double]
  omega

/-! ## Basic simplification -/

example (n : Nat) : double n + 0 = double n := by
  simp

example (n : Nat) : double (n + 1) = double n + 2 := by
  simp

/-! ## Restricting the simp set -/

example (n : Nat) : n + 0 = n := by
  simp only [Nat.add_zero]

example (n : Nat) : 0 + n = n := by
  simp only [Nat.zero_add]

/-! ## Simplifying with hypotheses -/

example (n : Nat) (h : n = 5) : n + 0 = 5 := by
  simp [h]

example (n m : Nat) (h : n = m) : n + 0 = m := by
  simp [h]

/-! ## Definitional unfolding -/

example (n : Nat) : double n = n + n := by
  simp [double]

example (n : Nat) : double n = n * 2 := by
  simp [double]
  omega

/-! ## Rewriting explicitly -/

example (a b : Nat) (h : a = b) : a + 1 = b + 1 := by
  rw [h]

example (a b c : Nat) (h1 : a = b) (h2 : b = c) : a = c := by
  rw [h1, h2]
