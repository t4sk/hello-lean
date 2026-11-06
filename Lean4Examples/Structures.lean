/-
# Structures

Structures are records with named fields. Lean generates constructors,
projections, functional update syntax, and useful instances.
-/
import Std

/-! ## A basic structure -/

structure Point where
  x : Float
  y : Float
  deriving Repr, BEq, Inhabited

namespace Point

def origin : Point :=
  { x := 0.0, y := 0.0 }

def add (p q : Point) : Point :=
  { x := p.x + q.x, y := p.y + q.y }

end Point

#eval ({ x := 1.0, y := 2.0 } : Point)
#eval Point.origin.add { x := 3.0, y := 4.0 }

/-! ## Default field values and record update -/

structure Person where
  name : String
  age : Nat := 0
  deriving Repr

#eval ({ name := "Ada" } : Person)
#eval ({ name := "Ada", age := 36 } : Person).age

def birthday (p : Person) : Person :=
  { p with age := p.age + 1 }

#eval birthday { name := "Ada", age := 36 }

/-! ## Inheritance with `extends` -/

structure Student extends Person where
  id : Nat
  deriving Repr

def alice : Student :=
  { name := "Alice", age := 20, id := 42 }

#eval alice
#eval alice.toPerson
#eval alice.toPerson.name

/-! ## Structures in specifications -/

structure Range where
  lo : Nat
  hi : Nat
  valid : lo ≤ hi

#eval ({ lo := 1, hi := 5, valid := by omega } : Range)
