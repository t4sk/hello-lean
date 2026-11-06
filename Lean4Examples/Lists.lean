/-
# Lists

`List α` is an inductive type:

```
inductive List (α : Type) where
  | nil  : List α
  | cons : α → List α → List α
```

Lean's standard library provides many list operations and lemmas.
-/
import Std

def xs : List Nat :=
  [1, 2, 3, 4, 5]

/-! ## Common operations -/

#eval xs.map (· * 2)
#eval xs.filter (· % 2 == 0)
#eval xs.foldr (· + ·) 0
#eval xs.foldl (fun acc x => acc + x) 0
#eval xs.reverse
#eval xs.zip ["a", "b", "c"]
#eval List.range 5
#eval xs.take 2
#eval xs.drop 3
#eval xs.sum
#eval xs.find? (· > 3)
#eval xs.all (· > 0)
#eval xs.any (· > 4)
#eval xs[10]?
#eval xs.getLast?
#eval xs.count 3
#eval List.replicate 3 "hi"
#eval [[1, 2], [3, 4]].flatMap id

/-! ## Recursive definitions on lists -/

def myLength : List α → Nat
  | [] => 0
  | _ :: xs => 1 + myLength xs

def myAppend : List α → List α → List α
  | [], bs => bs
  | a :: as, bs => a :: myAppend as bs

#eval myLength [10, 20, 30]
#eval myAppend [1, 2] [3, 4]

/-! ## Induction proofs about lists -/

theorem length_map (f : α → β) (l : List α) :
    (l.map f).length = l.length := by
  induction l with
  | nil => rfl
  | cons x xs ih => simp [List.map, ih]

theorem append_assoc' (as bs cs : List α) :
    (as ++ bs) ++ cs = as ++ (bs ++ cs) := by
  induction as with
  | nil => rfl
  | cons a as ih => simp [ih]

theorem map_map' (f : α → β) (g : β → γ) (l : List α) :
    (l.map f).map g = l.map (g ∘ f) := by
  induction l with
  | nil => rfl
  | cons x xs ih => simp [List.map, ih]
