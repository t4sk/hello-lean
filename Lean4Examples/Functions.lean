/-
# Functions

Functions are first-class values: they can be passed to, returned from,
and stored in other functions. Lean curries every multi-argument function.
-/
import Std

/-! ## Currying and partial application -/

def add (a b : Nat) : Nat :=
  a + b

#eval add 2 3
#eval (add 2) 3
#check add 2

/-! ## Higher-order functions -/

def applyTwice {α : Type} (f : α → α) (x : α) : α :=
  f (f x)

#eval applyTwice (· + 3) 1
#eval applyTwice (· * 2) 5

def compose {α β γ : Type} (f : β → γ) (g : α → β) (x : α) : γ :=
  f (g x)

#eval compose (· + 1) (· * 2) 10
#eval ((· + 1) ∘ (· * 2)) 10

#eval [1, 2, 3, 4].map (· * 2)
#eval [1, 2, 3, 4].filter (· % 2 == 0)

/-! ## Anonymous functions and sections -/

#eval (fun x => x + 1) 4
#eval (· + 1) 4
#eval (fun x y => x * y) 6 7

/-! ## Implicit arguments and named arguments -/

def greet (name : String := "world") (greeting : String := "Hello") : String :=
  s!"{greeting}, {name}!"

#eval greet
#eval greet "Lean"
#eval greet "Lean" (greeting := "Hi")

/-! ## Recursive functions and pattern matching -/

def foldSum : List Nat → Nat
  | [] => 0
  | x :: xs => x + foldSum xs

#eval foldSum [1, 2, 3, 4]

def flipArgs {α β γ : Type} (f : α → β → γ) (b : β) (a : α) : γ :=
  f a b

#eval flipArgs (· - ·) 3 10
