/-
# Syntax and macros

Lean's parser is extensible. `syntax` introduces new syntax, `macro_rules`
or `macro` expands it back into existing terms.
-/
import Lean

open Lean

/-! ## A term macro -/

syntax "twice " term : term

macro_rules
  | `(twice $x) => `($x + $x)

#eval twice 21

macro "square " x:term : term => `($x * $x)

#eval square 7

/-! ## A custom infix operator -/

infixl:65 " +! " => Nat.add

#eval 3 +! 4 +! 5

/-! ## A macro with several arguments -/

syntax "avg3" term:max term:max term:max : term

macro_rules
  | `(avg3 $a $b $c) => `(($a + $b + $c) / 3)

#eval avg3 3 6 9

/-! ## Hygiene -/

macro "ourConst" : term => `(42)

#eval ourConst

/-! ## Quoting and syntax inspection -/

def prettyTwice : Lean.MacroM Lean.Term := do
  let stx ← `(twice 10)
  return stx

#check prettyTwice
