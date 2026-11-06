/-
# `do` notation

`do` notation makes monadic code readable. It works for `Option`, `Except`,
`IO`, `StateM`, and any other `Monad`.
-/
import Std

/-! ## `Option` -/

def firstEven (xs : List Nat) : Option Nat := do
  let x ← xs.find? (· % 2 == 0)
  return x * 10

#eval firstEven [1, 3, 4, 5]
#eval firstEven [1, 3, 5]

def safeDivM (a b : Nat) : Option Nat := do
  if b == 0 then
    none
  else
    some (a / b)

#eval safeDivM 10 2
#eval safeDivM 10 0

/-! ## Mutable-looking code with `Id.run` -/

def sumTo (n : Nat) : Nat := Id.run do
  let mut acc := 0
  for i in List.range (n + 1) do
    acc := acc + i
  return acc

#eval sumTo 5

def countEvens (xs : List Nat) : Nat := Id.run do
  let mut count := 0
  for x in xs do
    if x % 2 == 0 then
      count := count + 1
  return count

#eval countEvens [1, 2, 3, 4, 5, 6]

def firstGreaterThan (xs : List Nat) (k : Nat) : Option Nat := Id.run do
  for x in xs do
    if x > k then
      return some x
  return none

#eval firstGreaterThan [1, 5, 9] 4
#eval firstGreaterThan [1, 2] 4

/-! ## `Except` -/

def parsePositiveDo (s : String) : Except String Nat := do
  let n ← match s.toNat? with
    | some n => pure n
    | none => throw s!"not a number: {s}"
  if n == 0 then
    throw "must be positive"
  else
    pure n

#eval parsePositiveDo "42"
#eval parsePositiveDo "-1"
#eval parsePositiveDo "zero"
