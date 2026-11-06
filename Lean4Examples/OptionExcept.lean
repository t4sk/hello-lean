/-
# `Option` and `Except`

`Option α` represents a possibly missing value. `Except ε α` represents
a computation that either fails with an error of type `ε` or succeeds
with a value of type `α`.
-/
import Std

/-! ## `Option` -/

def safeDiv (a b : Nat) : Option Nat :=
  if b == 0 then none else some (a / b)

#eval safeDiv 10 2
#eval safeDiv 10 0

def lookupAge (people : List (String × Nat)) (name : String) : Option Nat :=
  people.lookup name

#eval lookupAge [("Ada", 36), ("Bob", 20)] "Ada"
#eval lookupAge [("Ada", 36)] "Carol"

#eval (some 3).map (· + 1)
#eval (none : Option Nat).getD 0
#eval (some 5).bind fun x => if x > 3 then some (x * 2) else none
#eval Option.isSome (some 1)
#eval Option.isNone (none : Option Nat)

/-! ## `Except` -/

def safeDivExcept (a b : Nat) : Except String Nat :=
  if b == 0 then
    throw "division by zero"
  else
    pure (a / b)

#eval safeDivExcept 10 2
#eval safeDivExcept 10 0

def parsePositive (s : String) : Except String Nat := do
  let n ← match s.toNat? with
    | some n => pure n
    | none => throw s!"not a number: {s}"
  if n == 0 then
    throw "must be positive"
  else
    pure n

#eval parsePositive "42"
#eval parsePositive "0"
#eval parsePositive "abc"

/-! ## Chaining successful lookups -/

def lookupThenDouble (people : List (String × Nat)) (name : String) : Option Nat := do
  let age ← lookupAge people name
  return age * 2

#eval lookupThenDouble [("Ada", 36), ("Bob", 20)] "Ada"
#eval lookupThenDouble [("Ada", 36)] "Carol"
