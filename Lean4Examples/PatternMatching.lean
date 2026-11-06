/-
# Pattern matching

Patterns inspect the shape of a value. Lean supports matching in function
equations, `match` expressions, `let` bindings, and `fun` expressions.
-/
import Std

/-! ## Function equations -/

def fib : Nat → Nat
  | 0 => 0
  | 1 => 1
  | n + 2 => fib n + fib (n + 1)

#eval fib 10

def classify (n : Nat) : String :=
  match n with
  | 0 => "zero"
  | n => if n % 2 == 0 then "even" else "odd"

#eval classify 0
#eval classify 7

/-! ## Nested patterns -/

def firstTwo : List α → Option (α × α)
  | a :: b :: _ => some (a, b)
  | _ => none

#eval firstTwo [1, 2, 3]
#eval firstTwo [1]

def sumPair : Nat × Nat → Nat
  | (a, b) => a + b

#eval sumPair (3, 4)

/-! ## Matching on `Option` and structures -/

def head? : List α → Option α
  | [] => none
  | x :: _ => some x

def unwrap (o : Option α) (fallback : α) : α :=
  match o with
  | some x => x
  | none => fallback

#eval unwrap (head? [10, 20]) 0
#eval unwrap (head? ([] : List Nat)) 0

/-! ## As-patterns -/

def duplicateFirst : List α → List α
  | [] => []
  | h@(x :: _) => x :: h

#eval duplicateFirst [1, 2, 3]

/-! ## Patterns in `let` and `fun` -/

def swap (p : α × β) : β × α :=
  let (a, b) := p
  (b, a)

#eval swap (1, "one")

#eval (fun (a, b) => a + b) (10, 20)
