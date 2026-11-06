/-
# Inductive types

`inductive` declares a type by giving its constructors. Recursive occurrences
of the type in constructor arguments make it a recursive data type.
-/
import Std

/-! ## An enumeration -/

inductive Color where
  | red
  | green
  | blue
  deriving BEq, Repr, DecidableEq, Inhabited

#eval Color.red
#eval Color.red == Color.blue
#eval Color.red == Color.red

/-! ## A recursive binary tree -/

inductive Tree (α : Type) where
  | leaf : Tree α
  | node : Tree α → α → Tree α → Tree α
  deriving Repr

namespace Tree

def size : Tree α → Nat
  | .leaf => 0
  | .node l _ r => l.size + 1 + r.size

def insert [Ord α] (x : α) : Tree α → Tree α
  | .leaf => .node .leaf x .leaf
  | .node l y r =>
    match compare x y with
    | .lt => .node (l.insert x) y r
    | .gt => .node l y (r.insert x)
    | .eq => .node l y r

def toList : Tree α → List α
  | .leaf => []
  | .node l x r => l.toList ++ [x] ++ r.toList

end Tree

def sampleTree : Tree Nat :=
  Tree.insert 4 (Tree.insert 2 (Tree.insert 6 (Tree.insert 1 Tree.leaf)))

#eval sampleTree
#eval sampleTree.size
#eval sampleTree.toList

/-! ## A small JSON-like data type -/

inductive Json where
  | null
  | bool : Bool → Json
  | num : Int → Json
  | str : String → Json
  | arr : List Json → Json
  | obj : List (String × Json) → Json
  deriving Repr

#eval Json.obj [("name", Json.str "Ada"), ("age", Json.num 36)]
