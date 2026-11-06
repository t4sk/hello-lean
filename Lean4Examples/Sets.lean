/-
# Sets

In Lean, a set of elements of type `α` can be represented as a predicate
`α → Prop`. This file develops a small set API and proves some basic laws.
-/
import Std

def Set (α : Type) : Type :=
  α → Prop

namespace Set

variable {α : Type}

def empty : Set α :=
  fun _ => False

def univ : Set α :=
  fun _ => True

def mem (x : α) (s : Set α) : Prop :=
  s x

def insert (x : α) (s : Set α) : Set α :=
  fun y => y = x ∨ s y

def union (s t : Set α) : Set α :=
  fun x => s x ∨ t x

def inter (s t : Set α) : Set α :=
  fun x => s x ∧ t x

def compl (s : Set α) : Set α :=
  fun x => ¬ s x

def subset (s t : Set α) : Prop :=
  ∀ x, s x → t x

infix:50 " ∈ₛ " => mem
infix:60 " ∪ₛ " => union
infix:60 " ∩ₛ " => inter
infix:50 " ⊆ₛ " => subset

/-! ## Membership -/

theorem mem_insert_self (x : α) (s : Set α) : x ∈ₛ insert x s := by
  left
  rfl

theorem mem_insert_of_mem (x y : α) (s : Set α) (h : x ∈ₛ s) :
    x ∈ₛ insert y s := by
  right
  exact h

theorem mem_union_left (x : α) (s t : Set α) (h : x ∈ₛ s) : x ∈ₛ s ∪ₛ t := by
  left
  exact h

theorem mem_union_right (x : α) (s t : Set α) (h : x ∈ₛ t) : x ∈ₛ s ∪ₛ t := by
  right
  exact h

/-! ## Subsets -/

theorem subset_refl (s : Set α) : s ⊆ₛ s := by
  intro x hx
  exact hx

theorem subset_trans (s t u : Set α) (h1 : s ⊆ₛ t) (h2 : t ⊆ₛ u) : s ⊆ₛ u := by
  intro x hx
  exact h2 x (h1 x hx)

theorem empty_subset (s : Set α) : empty ⊆ₛ s := by
  intro x hx
  exact False.elim hx

/-! ## Unions and intersections -/

theorem union_comm (s t : Set α) : s ∪ₛ t = t ∪ₛ s := by
  funext x
  apply propext
  constructor <;> intro h
  · cases h with
    | inl hs => right; exact hs
    | inr ht => left; exact ht
  · cases h with
    | inl ht => right; exact ht
    | inr hs => left; exact hs

theorem inter_comm (s t : Set α) : s ∩ₛ t = t ∩ₛ s := by
  funext x
  apply propext
  constructor <;> intro h
  · exact ⟨h.2, h.1⟩
  · exact ⟨h.2, h.1⟩

theorem union_subset (s t u : Set α) (hs : s ⊆ₛ u) (ht : t ⊆ₛ u) :
    s ∪ₛ t ⊆ₛ u := by
  intro x hx
  cases hx with
  | inl h => exact hs x h
  | inr h => exact ht x h

end Set
