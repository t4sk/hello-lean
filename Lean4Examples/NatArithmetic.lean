/-
# Natural number arithmetic

Lean's `Nat` type comes with many lemmas. `omega` solves linear arithmetic
over `Nat` and `Int`; algebraic identities are usually applied directly.
-/
import Std

namespace NatArithmetic

theorem add_comm_nat (a b : Nat) : a + b = b + a :=
  Nat.add_comm a b

theorem add_assoc_nat (a b c : Nat) : a + b + c = a + (b + c) :=
  Nat.add_assoc a b c

theorem mul_comm_nat (a b : Nat) : a * b = b * a :=
  Nat.mul_comm a b

theorem mul_distrib_nat (a b c : Nat) :
    a * (b + c) = a * b + a * c :=
  Nat.mul_add a b c

/-! ## Linear arithmetic with `omega` -/

example (n : Nat) : 0 < n + 1 := by
  omega

example (a b : Nat) (h : a ≤ b) : a + 1 ≤ b + 1 := by
  omega

example (a b c : Nat) (h1 : a ≤ b) (h2 : b ≤ c) : a ≤ c := by
  omega

/-! ## A nonlinear inequality via lemmas -/

example (n : Nat) : n ≤ n * (n + 1) := by
  have h : 1 ≤ n + 1 := by omega
  calc
    n = n * 1 := by rw [Nat.mul_one]
    _ ≤ n * (n + 1) := Nat.mul_le_mul_left n h

/-! ## Divisibility -/

example : 3 ∣ 12 :=
  ⟨4, rfl⟩

example (n : Nat) : n ∣ n :=
  ⟨1, by simp⟩

theorem dvd_trans_nat {a b c : Nat} (h1 : a ∣ b) (h2 : b ∣ c) : a ∣ c :=
  Nat.dvd_trans h1 h2

theorem dvd_add_nat {a b c : Nat} (h1 : a ∣ b) (h2 : a ∣ c) : a ∣ b + c := by
  obtain ⟨x, rfl⟩ := h1
  obtain ⟨y, rfl⟩ := h2
  exact ⟨x + y, by rw [Nat.mul_add]⟩

/-! ## Parity by induction -/

def Even (n : Nat) : Prop :=
  ∃ k, n = 2 * k

theorem even_add (a b : Nat) : Even a → Even b → Even (a + b) := by
  rintro ⟨x, rfl⟩ ⟨y, rfl⟩
  exact ⟨x + y, by omega⟩

theorem even_mul_two (n : Nat) : Even (2 * n) :=
  ⟨n, rfl⟩

end NatArithmetic
