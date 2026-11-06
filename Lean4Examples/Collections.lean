/-
# Collections

Lean's standard library includes hash-based and tree-based collections.
`HashMap` and `HashSet` require `BEq` and `Hashable`; `TreeMap` and
`TreeSet` require an ordering.
-/
import Std

open Std

/-! ## `HashMap` -/

def ages : Std.HashMap String Nat :=
  Std.HashMap.emptyWithCapacity
    |>.insert "Ada" 36
    |>.insert "Bob" 20

#eval ages.get? "Ada"
#eval ages.getD "Carol" 0
#eval ages.contains "Bob"
#eval ages.size
#eval ages.keys
#eval ages.values
#eval ages.toList
#eval ages.erase "Bob" |>.size

/-! ## `HashSet` -/

def primes : Std.HashSet Nat :=
  Std.HashSet.emptyWithCapacity
    |>.insert 2
    |>.insert 3
    |>.insert 5

#eval primes.contains 3
#eval primes.contains 4
#eval primes.size
#eval primes.toList

/-! ## `TreeMap` keeps keys ordered -/

def capitals : Std.TreeMap String String :=
  Std.TreeMap.empty
    |>.insert "France" "Paris"
    |>.insert "Japan" "Tokyo"
    |>.insert "Brazil" "Brasília"

#eval capitals.get? "Japan"
#eval capitals.toList
#eval capitals.contains "France"

/-! ## A word-count example -/

def wordCount (words : List String) : Std.HashMap String Nat :=
  words.foldl
    (fun counts word => counts.insert word (counts.getD word 0 + 1))
    Std.HashMap.emptyWithCapacity

#eval wordCount ["a", "b", "a", "c", "a"]
