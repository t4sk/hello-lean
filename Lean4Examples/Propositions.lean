/-
# Propositions and proofs

In Lean, a proposition is a type, and a proof is a term of that type.
The basic connectives are `True`, `False`, `∧`, `∨`, `¬`, and `↔`.
-/
import Std

/-! ## Truth and falsity -/

example : True := by
  trivial

example : False → False := by
  intro h
  exact h

example : False → True := by
  intro h
  exact False.elim h

example : ¬False := by
  intro h
  exact h

/-! ## Conjunction -/

example : True ∧ True := by
  constructor <;> trivial

example : 1 = 1 ∧ 2 = 2 := by
  constructor <;> rfl

theorem prop_and_comm (p q : Prop) : p ∧ q → q ∧ p := by
  intro h
  exact ⟨h.2, h.1⟩

/-! ## Disjunction -/

example : True ∨ False := by
  left
  trivial

example : False ∨ True := by
  right
  trivial

theorem prop_or_comm (p q : Prop) : p ∨ q → q ∨ p := by
  intro h
  cases h with
  | inl hp => right; exact hp
  | inr hq => left; exact hq

/-! ## Negation -/

theorem prop_not_not_intro (p : Prop) : p → ¬¬p := by
  intro hp hn
  exact hn hp

example (p : Prop) (hp : p) (hn : ¬p) : False := by
  exact hn hp

/-! ## If and only if -/

example : True ↔ True := by
  constructor <;> intro h <;> exact h

theorem iff_self_prop (p : Prop) : p ↔ p := by
  constructor <;> intro h <;> exact h

theorem iff_symm (p q : Prop) : (p ↔ q) → (q ↔ p) := by
  intro h
  exact ⟨h.2, h.1⟩
