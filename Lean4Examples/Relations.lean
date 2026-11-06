/-
# Relations

A relation on `α` is a function `α → α → Prop`. Important classes of
relations include preorders, partial orders, and equivalence relations.
-/
import Std

namespace Rel

variable {α : Type}

def Reflexive (r : α → α → Prop) : Prop :=
  ∀ x, r x x

def Symmetric (r : α → α → Prop) : Prop :=
  ∀ x y, r x y → r y x

def Transitive (r : α → α → Prop) : Prop :=
  ∀ x y z, r x y → r y z → r x z

def Antisymmetric (r : α → α → Prop) : Prop :=
  ∀ x y, r x y → r y x → x = y

structure Equivalence (r : α → α → Prop) : Prop where
  refl : Reflexive r
  symm : Symmetric r
  trans : Transitive r

structure PartialOrder (r : α → α → Prop) : Prop where
  refl : Reflexive r
  trans : Transitive r
  antisymm : Antisymmetric r

def converse (r : α → α → Prop) : α → α → Prop :=
  fun x y => r y x

def comp (r s : α → α → Prop) : α → α → Prop :=
  fun x z => ∃ y, r x y ∧ s y z

end Rel

/-! ## Equality is an equivalence relation -/

theorem eq_equivalence : Rel.Equivalence (fun a b : Nat => a = b) where
  refl := by intro x; rfl
  symm := by intro x y h; exact h.symm
  trans := by intro x y z h1 h2; exact h1.trans h2

/-! ## Congruence modulo 3 -/

def Eqv (a b : Nat) : Prop :=
  a % 3 = b % 3

theorem eqv_equivalence : Rel.Equivalence Eqv where
  refl := by
    intro x
    rfl
  symm := by
    intro x y h
    exact h.symm
  trans := by
    intro x y z h1 h2
    exact h1.trans h2

/-! ## `≤` on natural numbers is a partial order -/

theorem nat_le_partial_order : Rel.PartialOrder (fun a b : Nat => a ≤ b) where
  refl := by intro x; exact Nat.le_refl x
  trans := by intro x y z h1 h2; exact Nat.le_trans h1 h2
  antisymm := by intro x y h1 h2; omega

/-! ## Converse of a relation -/

theorem le_converse_ge (a b : Nat) :
    Rel.converse (fun x y : Nat => x ≤ y) a b ↔ b ≤ a :=
  Iff.rfl

/-! ## Composition of relations -/

def Even (n : Nat) : Prop :=
  n % 2 = 0

def EvenRel (_ : Nat) (b : Nat) : Prop :=
  Even b

def Succ (a b : Nat) : Prop :=
  b = a + 1

#check Rel.comp Succ EvenRel
