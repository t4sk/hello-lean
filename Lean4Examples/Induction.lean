/-
# Induction

`induction` performs structural induction on a value. For `Nat` this is
the usual zero/successor principle; for lists and trees it follows the
constructors.
-/
import Std

/-! ## Induction on natural numbers -/

theorem zero_add_proof (n : Nat) : 0 + n = n := by
  induction n with
  | zero => rfl
  | succ n ih => rw [Nat.add_succ, ih]

theorem succ_add_proof (n m : Nat) : (n + 1) + m = n + m + 1 := by
  induction m with
  | zero => rfl
  | succ m ih => omega

/-! ## Induction on lists -/

theorem replicate_length (n : Nat) (x : α) :
    (List.replicate n x).length = n := by
  induction n with
  | zero => rfl
  | succ n ih => simp [List.replicate, ih]

theorem append_assoc_induction (as bs cs : List α) :
    (as ++ bs) ++ cs = as ++ (bs ++ cs) := by
  induction as with
  | nil => rfl
  | cons a as ih => simp [ih]

theorem map_map_induction (f : α → β) (g : β → γ) (xs : List α) :
    (xs.map f).map g = xs.map (g ∘ f) := by
  induction xs with
  | nil => rfl
  | cons x xs ih => simp [List.map, ih]

/-! ## Induction on a custom inductive type -/

inductive IndTree where
  | leaf : IndTree
  | node : IndTree → Nat → IndTree → IndTree

namespace IndTree

def size : IndTree → Nat
  | .leaf => 0
  | .node l _ r => l.size + 1 + r.size

def mirror : IndTree → IndTree
  | .leaf => .leaf
  | .node l x r => .node (mirror r) x (mirror l)

theorem size_mirror (t : IndTree) : t.mirror.size = t.size := by
  induction t with
  | leaf => rfl
  | node l x r ihl ihr =>
    simp [mirror, size, ihl, ihr]
    omega

end IndTree
