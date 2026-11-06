/-
# Classical logic

Lean's core logic is constructive by default, but classical reasoning is
available through `Classical`. Classical results are marked `noncomputable`
when they produce data.
-/
import Std

open Classical

/-! ## Excluded middle -/

theorem em_example (p : Prop) : p ∨ ¬p :=
  em p

#check Classical.em

/-! ## Double negation elimination -/

theorem dn_classical (p : Prop) : ¬¬p → p := by
  intro h
  apply Classical.byContradiction
  intro hn
  exact h hn

/-! ## Peirce's law -/

theorem peirce_law (p q : Prop) : ((p → q) → p) → p := by
  intro h
  apply Classical.byContradiction
  intro hp
  have hp' : p := h (fun hp'' => False.elim (hp hp''))
  exact hp hp'

/-! ## Classical choice -/

noncomputable def pick (h : ∃ n : Nat, n > 5) : Nat :=
  Classical.choose h

theorem pick_spec (h : ∃ n : Nat, n > 5) : pick h > 5 :=
  Classical.choose_spec h

/-! ## Proving a classical statement -/

theorem not_forall_exists_not (p : Nat → Prop) :
    ¬(∀ n, p n) → ∃ n, ¬p n := by
  intro h
  apply Classical.byContradiction
  intro hnone
  apply h
  intro n
  apply Classical.byContradiction
  intro hn
  exact hnone ⟨n, hn⟩

/-! ## Decidable classical tautologies -/

example (p q : Prop) : (p → q) ∨ (q → p) := by
  by_cases hp : p
  · by_cases hq : q
    · left; intro _; exact hq
    · right; intro hq'; exact False.elim (hq hq')
  · left; intro hp'; exact False.elim (hp hp')
