/-
# Strings

`String` is a sequence of Unicode characters. Lean has convenient syntax
for string literals, interpolation, and many common operations.
-/
import Std

def s : String :=
  "Hello, Lean 4!"

#eval s
#eval s.length
#eval s.toList
#eval "abc" ++ "def"
#eval s.splitOn ", "
#eval "  hi  ".trim
#eval s.toUpper
#eval s.toLower
#eval "Lean".push '!'
#eval String.intercalate ", " ["a", "b", "c"]
#eval "42".toNat?
#eval "abc".toNat?

/-! ## String interpolation -/

def describePerson (name : String) (age : Nat) : String :=
  s!"{name} is {age} years old."

#eval describePerson "Ada" 36

#eval s!"The length of {s} is {s.length}"

/-! ## Predicates and slicing -/

#eval "abc".startsWith "ab"
#eval "abc".endsWith "bc"
#eval "abc".contains 'b'
#eval "hello world".replace "world" "Lean"
#eval "abcdef".take 3
#eval "abcdef".drop 3

/-! ## Recursion over characters -/

def countChar (c : Char) (s : String) : Nat :=
  s.toList.count c

#eval countChar 'l' "Hello, Lean 4!"

def reverseString (s : String) : String :=
  String.mk s.toList.reverse

#eval reverseString "Lean"
