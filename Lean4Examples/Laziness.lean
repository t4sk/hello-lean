/-
# Laziness and infinite structures

Lean is an eager language, but `Thunk` delays a computation until its
value is needed. This lets us build infinite sequences as coinductive data.
-/
import Std

/-! ## `Thunk` -/

def delayed : Thunk Nat :=
  Thunk.mk fun _ => 6 * 7

#eval delayed.get

/-! ## An infinite lazy list -/

structure LazyList (α : Type) where
  head : α
  tail : Thunk (LazyList α)

def LazyList.take : Nat → LazyList α → List α
  | 0, _ => []
  | n + 1, xs => xs.head :: xs.tail.get.take n

unsafe def natsFrom (n : Nat) : LazyList Nat :=
  { head := n, tail := Thunk.mk fun _ => natsFrom (n + 1) }

#eval (natsFrom 0).take 10

unsafe def LazyList.map (f : α → β) (xs : LazyList α) : LazyList β :=
  { head := f xs.head, tail := Thunk.mk fun _ => (xs.tail.get).map f }

#eval ((natsFrom 0).map (· * 2)).take 5

/-! ## Infinite sequences as functions -/

def nats : Nat → Nat :=
  fun n => n

def LazyNat.take (xs : Nat → Nat) (n : Nat) : List Nat :=
  (List.range n).map xs

#eval LazyNat.take nats 10

def LazyNat.map (f : Nat → Nat) (xs : Nat → Nat) : Nat → Nat :=
  fun i => f (xs i)

#eval LazyNat.take (LazyNat.map (· * 2) nats) 5

/-! ## The core `Stream` class powers parallel `for` loops -/

#eval Id.run do
  let mut sum := 0
  for x in [1, 2, 3], y in [10, 20, 30] do
    sum := sum + x * y
  return sum
