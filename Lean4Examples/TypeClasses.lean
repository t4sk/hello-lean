/-
# Type classes

Type classes provide ad-hoc polymorphism. A class declares operations
(and possibly laws or default implementations); instances provide the
implementations for concrete types.
-/
import Std

/-! ## A simple class -/

class Describable (α : Type) where
  describe : α → String

instance : Describable Nat where
  describe n := s!"Nat({n})"

instance : Describable Bool where
  describe b := if b then "true" else "false"

def showIt [Describable α] (x : α) : String :=
  Describable.describe x

#eval showIt 42
#eval showIt true

/-! ## A higher-kinded class -/

class Container (F : Type → Type) where
  empty : {α : Type} → F α
  insert : {α : Type} → α → F α → F α
  toList : {α : Type} → F α → List α

instance : Container List where
  empty := []
  insert := List.cons
  toList := id

#eval Container.toList
  (Container.insert 1 (Container.insert 2 (Container.empty : List Nat)))

/-! ## A class with laws and default methods -/

class Named (α : Type) where
  name : String
  greeting : String := "Hello from " ++ name

instance : Named Nat where
  name := "natural number"

instance : Named Bool where
  name := "boolean"
  greeting := "Hi from the booleans"

def introduce [Named α] (_ : α) : String :=
  Named.greeting (α := α)

#eval introduce (0 : Nat)
#eval introduce true

/-! ## Working with existing classes -/

#eval (5 : Nat) + 7
#eval (5.5 : Float) + 2.0
#eval "a" ++ "b"

def sumAll [Add α] [Zero α] (xs : List α) : α :=
  xs.foldr (· + ·) 0

#eval sumAll [1, 2, 3, 4]
#eval sumAll [1.5, 2.5]
