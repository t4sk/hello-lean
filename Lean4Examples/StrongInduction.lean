/-
# Strong induction and well-founded recursion

Strong induction allows the inductive hypothesis to be used for *all*
smaller numbers, not only the immediate predecessor.
-/
import Std

/-! ## The strong induction principle -/

theorem nat_strong_induction {P : Nat → Prop}
    (h : ∀ n, (∀ m, m < n → P m) → P n) : ∀ n, P n := by
  intro n
  exact Nat.strongRecOn n h

example (n : Nat) : n < n + 1 := by
  induction n using Nat.strongRecOn with
  | ind n ih => omega

/-! ## Well-founded recursion in a definition -/

def fibFast (n : Nat) : Nat :=
  match n with
  | 0 => 0
  | 1 => 1
  | n + 2 => fibFast n + fibFast (n + 1)
termination_by n
decreasing_by all_goals omega

#eval fibFast 10
#eval fibFast 20

/-! ## A proof by strong induction -/

theorem strong_rec_sum (n : Nat) :
    n + 0 = n := by
  induction n using Nat.strongRecOn with
  | ind n ih => rfl

/-! ## Well-founded recursion with an explicit relation -/

def countdown : Nat → List Nat
  | 0 => [0]
  | n + 1 => (n + 1) :: countdown n

#eval countdown 5

/-! ## A minimal element example -/

theorem exists_minimal (P : Nat → Prop) (n : Nat) (h : P n) :
    ∃ m, P m ∧ ∀ k, k < m → ¬P k := by
  induction n using Nat.strongRecOn with
  | ind n ih =>
    by_cases hsmall : ∃ k, k < n ∧ P k
    · obtain ⟨k, hklt, hkP⟩ := hsmall
      exact ih k hklt hkP
    · refine ⟨n, h, ?_⟩
      intro k hk
      exact fun hkP => hsmall ⟨k, hk, hkP⟩
