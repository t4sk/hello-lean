/-
# Recursion and termination

Lean accepts recursion when it can prove that the recursive call is on a
structurally smaller argument, or when the user supplies a termination
measure and a proof that it decreases.
-/
import Std

/-! ## Structural recursion -/

def factorial : Nat → Nat
  | 0 => 1
  | n + 1 => (n + 1) * factorial n

#eval factorial 5

def sumList : List Nat → Nat
  | [] => 0
  | x :: xs => x + sumList xs

#eval sumList [1, 2, 3, 4]

/-! ## A termination measure -/

def gcd (a b : Nat) : Nat :=
  if b = 0 then
    a
  else
    gcd b (a % b)
termination_by b
decreasing_by
  apply Nat.mod_lt
  omega

#eval gcd 12 18
#eval gcd 1071 462

/-! ## Recursion on a custom inductive type -/

inductive BinTree where
  | leaf : BinTree
  | node : BinTree → Nat → BinTree → BinTree

def BinTree.sum : BinTree → Nat
  | .leaf => 0
  | .node l x r => l.sum + x + r.sum

def BinTree.depth : BinTree → Nat
  | .leaf => 0
  | .node l _ r => 1 + max l.depth r.depth

def sample : BinTree :=
  .node (.node .leaf 2 .leaf) 1 (.node .leaf 3 .leaf)

#eval sample.sum
#eval sample.depth

/-! ## Mutual recursion -/

mutual
  def isEven : Nat → Bool
    | 0 => true
    | n + 1 => isOdd n

  def isOdd : Nat → Bool
    | 0 => false
    | n + 1 => isEven n
end

#eval isEven 10
#eval isOdd 7
