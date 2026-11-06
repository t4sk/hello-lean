/-
# Equality

`a = b` is an inductive proposition whose only constructor is `rfl`.
Equality can be used to rewrite goals and hypotheses.
-/
import Std

/-! ## Reflexivity -/

example : 2 + 2 = 4 := rfl
example (n : Nat) : n = n := rfl

/-! ## Symmetry and transitivity -/

example (a b : Nat) (h : a = b) : b = a :=
  h.symm

example (a b c : Nat) (h1 : a = b) (h2 : b = c) : a = c :=
  h1.trans h2

/-! ## Rewriting -/

example (a b : Nat) (h : a = b) : a + 1 = b + 1 := by
  rw [h]

example (f : Nat → Nat) (a b : Nat) (h : a = b) : f a = f b := by
  rw [h]

example (a b c : Nat) (h1 : a = b) (h2 : b = c) : a = c := by
  rw [h1, h2]

/-! ## Substitution -/

example (a b : Nat) (h : a = b) : a + 1 = b + 1 := by
  subst h
  rfl

/-! ## Congruence -/

example (a b : Nat) (h : a = b) : a * 2 = b * 2 := by
  exact congrArg (· * 2) h

example (a b : Nat) (h : a = b) : a + 5 = b + 5 := by
  exact congrArg (· + 5) h

/-! ## Calculational proofs -/

example (a b c : Nat) (h1 : a = b) (h2 : b = c) : a = c := by
  calc
    a = b := h1
    _ = c := h2

example (a b c : Nat) : a + b + c = a + (b + c) := by
  calc
    a + b + c = a + (b + c) := Nat.add_assoc a b c

/-! ## Using known lemmas -/

example (n : Nat) : n + 0 = n :=
  Nat.add_zero n

example (a b : Nat) : a + b = b + a :=
  Nat.add_comm a b
