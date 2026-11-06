/-
# Integers

`Int` extends `Nat` with negative numbers. Many `Nat` lemmas have `Int`
counterparts, and `omega` works for linear integer arithmetic.
-/
import Std

namespace IntExamples

#eval (-5 : Int) + 3
#eval (7 : Int) / 2
#eval (7 : Int) % 2
#eval (-7 : Int).natAbs

example (a b : Int) : a + b = b + a :=
  Int.add_comm a b

example (a b c : Int) : a + b + c = a + (b + c) :=
  Int.add_assoc a b c

example (a : Int) : a + 0 = a :=
  Int.add_zero a

example (a : Int) : 0 + a = a :=
  Int.zero_add a

example (a : Int) : -a + a = 0 :=
  Int.add_left_neg a

example (a : Int) : a + -a = 0 :=
  Int.add_right_neg a

example (a b : Int) : a - b = a + -b := by
  omega

/-! ## Order and arithmetic -/

example (a b : Int) (h : a ≤ b) : a + 1 ≤ b + 1 := by
  omega

example (a b : Int) (h : a < b) : a ≤ b := by
  omega

example (n : Nat) : (n : Int) ≥ 0 := by
  omega

example (a : Int) : a < a + 1 := by
  omega

/-! ## Casts from `Nat` -/

example (n m : Nat) : ((n + m : Nat) : Int) = (n : Int) + (m : Int) := by
  omega

example (n : Nat) : ((-(n : Int)) + n) = 0 := by
  omega

end IntExamples
