/-
# Implication

An implication `p → q` is a function from proofs of `p` to proofs of `q`.
`intro` assumes the premise; `apply` and `exact` use implications.
-/
import Std

theorem modus_ponens (p q : Prop) (hp : p) (hpq : p → q) : q :=
  hpq hp

theorem imp_trans (p q r : Prop) (hpq : p → q) (hqr : q → r) : p → r := by
  intro hp
  exact hqr (hpq hp)

/-! ## Currying and uncurrying -/

theorem curry_prop (p q r : Prop) : (p ∧ q → r) → p → q → r := by
  intro h hp hq
  exact h ⟨hp, hq⟩

theorem uncurry_prop (p q r : Prop) : (p → q → r) → p ∧ q → r := by
  intro h hpq
  exact h hpq.1 hpq.2

/-! ## Using `apply` and `have` -/

example (p q : Prop) (hp : p) (hpq : p → q) : q := by
  apply hpq
  exact hp

example (p q r : Prop) (hp : p) (hpq : p → q) (hqr : q → r) : r := by
  have hq : q := hpq hp
  exact hqr hq

example (p q : Prop) (h : p) : q → p := by
  intro _
  exact h

/-! ## Arithmetic implications -/

theorem have_example (n : Nat) (h : n > 0) : n + 1 > 1 := by
  have h1 : n ≥ 1 := by omega
  omega
