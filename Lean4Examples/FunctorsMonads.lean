/-
# Functors, applicatives, and monads

`Functor` supports `map`, `Applicative` supports `pure` and `<*>`,
and `Monad` supports `bind` (`>>=`). Lean's `do` notation desugars to
these operations.
-/
import Std

/-! ## Built-in instances -/

#eval (some 2).map (· + 1)
#eval (· + 1) <$> some 2
#eval some (· + 1) <*> some 2
#eval (some 2).bind fun x => some (x * 3)
#eval [1, 2, 3].map (· * 2)

/-! ## A custom monad -/

structure Box (α : Type) where
  value : α

instance : Functor Box where
  map f b := { value := f b.value }

instance : Applicative Box where
  pure x := { value := x }
  seq f b := { value := f.value (b ()).value }

instance : Monad Box where
  bind b f := f b.value

#eval Functor.map (· * 2) (Box.mk 21 : Box Nat)

#eval ((do
  let x ← Box.mk 3
  let y ← Box.mk 4
  return x + y) : Box Nat)

/-! ## The state monad -/

def counter : StateM Nat Nat := do
  let n ← get
  set (n + 1)
  return n

def tickTwice : StateM Nat Nat := do
  let a ← counter
  let b ← counter
  return a + b

#eval counter.run 10
#eval tickTwice.run 0

def countThree : StateM Nat Unit := do
  let _ ← counter
  let _ ← counter
  let _ ← counter
  return ()

#eval countThree.run 0

/-! ## `Option` in `do` notation -/

#eval (do
  let x ← some 3
  let y ← some 4
  return x + y)

#eval [1, 2, 3].flatMap fun x => [x, x * 10]
