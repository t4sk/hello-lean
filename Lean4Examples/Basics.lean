/-
# Basics: terms, types, and definitions

Lean 4 is both a functional programming language and a proof assistant.
Everything is built from *terms*, and every term has a *type*.
-/
import Std

/-! ## Checking and evaluating expressions -/

#check Nat
#check Nat.add
#check (fun x => x + 1)
#check Prop
#check Type
#check Type 1

#eval 2 + 3
#eval String.length "Lean 4"
#eval (2, "two", true)

/-! ## Definitions -/

def square (n : Nat) : Nat :=
  n * n

#eval square 7

def greeting : String :=
  "Hello, Lean 4!"

def max' (a b : Nat) : Nat :=
  if a ≥ b then a else b

#eval max' 3 9

/-! ## Expressions: `let`, `if`, and `match` -/

def describe (n : Nat) : String :=
  match n with
  | 0 => "zero"
  | 1 => "one"
  | _ => "many"

#eval describe 0
#eval describe 5

def area (width height : Nat) : Nat :=
  let product := width * height
  product

#eval area 3 4

/-! ## A first proof -/

example : square 3 = 9 := rfl

example : 2 + 2 = 4 := rfl

/-! ## Universes and polymorphism -/

universe u

def identity {α : Type u} (x : α) : α :=
  x

#check @identity
#eval identity 42
#eval identity "Lean"
