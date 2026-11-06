/-
# Deriving instances

Lean can automatically generate common instances for inductive types and
structures: `BEq`, `Repr`, `Inhabited`, `DecidableEq`, `Ord`, `Hashable`,
and more.
-/
import Std

/-! ## Deriving several instances at once -/

inductive Light where
  | red
  | yellow
  | green
  deriving BEq, Repr, Inhabited, DecidableEq, Ord, Hashable

#eval Light.red
#eval Light.red == Light.green
#eval compare Light.red Light.green

/-! ## Deriving for structures -/

structure Coord where
  x : Int
  y : Int
  deriving BEq, Repr, Inhabited, DecidableEq, Ord

#eval ({ x := 1, y := 2 } : Coord)
#eval ({ x := 1, y := 2 } : Coord) == { x := 1, y := 2 }

/-! ## Using a derived `Hashable` instance -/

def lights : Std.HashSet Light :=
  Std.HashSet.emptyWithCapacity
    |>.insert Light.red
    |>.insert Light.green
    |>.insert Light.red

#eval lights.size
#eval lights.contains Light.red
#eval lights.contains Light.yellow

/-! ## A custom `Repr` instance -/

structure Secret where
  value : Nat

instance : Repr Secret where
  reprPrec s _ := s!"Secret(<hidden {s.value}>)"

#eval ({ value := 42 } : Secret)

/-! ## Derived instances are ordinary instances -/

example : (Light.red == Light.red) = true := rfl
example : Inhabited Light := inferInstance
example : DecidableEq Light := inferInstance
