/-
# Quantifiers

`∀ x, p x` is a dependent function type; `∃ x, p x` is an inductive type
whose constructor stores a witness and a proof.
-/
import Std

/-! ## Universal quantification -/

example : ∀ n : Nat, n = n := by
  intro n
  rfl

example : ∀ n : Nat, n ≥ 0 := by
  intro n
  omega

theorem forall_and_swap (p q : Nat → Prop) :
    (∀ n, p n ∧ q n) → (∀ n, p n) ∧ (∀ n, q n) := by
  intro h
  constructor
  · intro n; exact (h n).1
  · intro n; exact (h n).2

/-! ## Existential quantification -/

example : ∃ n : Nat, n + n = 4 :=
  ⟨2, by omega⟩

example : ∃ n : Nat, n > 5 :=
  ⟨6, by omega⟩

theorem exists_swap_prop (p : Nat → Nat → Prop) :
    (∃ a b, p a b) → ∃ b a, p a b := by
  intro h
  obtain ⟨a, b, hab⟩ := h
  exact ⟨b, a, hab⟩

/-! ## Combining quantifiers -/

theorem forall_exists (p : Nat → Nat → Prop) :
    (∃ a, ∀ b, p a b) → ∀ b, ∃ a, p a b := by
  intro h b
  obtain ⟨a, ha⟩ := h
  exact ⟨a, ha b⟩

/-! ## Destructuring with `rintro` -/

example (p q : Prop) : p ∧ q → q ∧ p := by
  rintro ⟨hp, hq⟩
  exact ⟨hq, hp⟩

example (p : Nat → Prop) (h : ∃ n, p n) : ∃ n, p n := by
  obtain ⟨n, hn⟩ := h
  exact ⟨n, hn⟩
