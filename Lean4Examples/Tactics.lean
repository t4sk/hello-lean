/-
# A tour of basic tactics

Tactics build proofs step by step. This file surveys the tactics used most
often in elementary proofs.
-/
import Std

/-! ## Closing goals -/

example : 1 + 1 = 2 := by rfl

example : 2 + 2 = 4 := by decide

example (n : Nat) : n + 0 = n := by simp

example (n : Nat) : n + 1 > n := by omega

example : True := by trivial

example (p : Prop) (h : p) : p := by assumption

/-! ## Introduction and application -/

example (p : Prop) : p → p := by
  intro h
  exact h

example (p q : Prop) (hp : p) (hpq : p → q) : q := by
  apply hpq
  exact hp

example (p q r : Prop) (hp : p) (hpq : p → q) (hqr : q → r) : r := by
  have hq : q := hpq hp
  exact hqr hq

/-! ## Constructors and case analysis -/

example (p q : Prop) (hp : p) (hq : q) : p ∧ q := by
  constructor
  · exact hp
  · exact hq

example (p q : Prop) (h : p ∨ q) : q ∨ p := by
  cases h with
  | inl hp => right; exact hp
  | inr hq => left; exact hq

example (p : Prop) (h : ¬p) : p → False := by
  intro hp
  exact h hp

/-! ## Contradiction -/

example (p : Prop) (hp : p) (hn : ¬p) : False := by
  contradiction

example (p : Prop) (hp : p) (hn : ¬p) : 42 = 0 := by
  exfalso
  exact hn hp

/-! ## Case splits -/

example (p : Prop) : p ∨ ¬p := by
  by_cases h : p
  · left; exact h
  · right; exact h

example (n : Nat) : n = 0 ∨ n > 0 := by
  by_cases h : n = 0
  · left; exact h
  · right; omega

example (p : Prop) : ¬¬p → p := by
  intro h
  apply Classical.byContradiction
  intro hn
  exact h hn
