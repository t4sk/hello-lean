/-
# Algebraic structures

Type classes let us state algebraic laws once and prove theorems for every
instance. Here we define additive monoids and additive groups.
-/
import Std

namespace MyAdd

class MyAddMonoid (α : Type) where
  add : α → α → α
  zero : α
  add_assoc : ∀ a b c, add (add a b) c = add a (add b c)
  zero_add : ∀ a, add zero a = a
  add_zero : ∀ a, add a zero = a

class MyAddGroup (α : Type) extends MyAddMonoid α where
  neg : α → α
  neg_add_cancel : ∀ a, add (neg a) a = zero
  add_neg_cancel : ∀ a, add a (neg a) = zero

/-! ## Instances -/

instance : MyAddMonoid Nat where
  add := Nat.add
  zero := 0
  add_assoc := Nat.add_assoc
  zero_add := Nat.zero_add
  add_zero := Nat.add_zero

instance : MyAddMonoid Int where
  add := Int.add
  zero := 0
  add_assoc := Int.add_assoc
  zero_add := Int.zero_add
  add_zero := Int.add_zero

instance : MyAddGroup Int where
  neg := Int.neg
  neg_add_cancel := Int.add_left_neg
  add_neg_cancel := Int.add_right_neg

/-! ## Generic definitions and proofs -/

def double [MyAddMonoid α] (a : α) : α :=
  MyAddMonoid.add a a

theorem add_assoc_four [MyAddMonoid α] (a b c d : α) :
    MyAddMonoid.add (MyAddMonoid.add (MyAddMonoid.add a b) c) d =
    MyAddMonoid.add a (MyAddMonoid.add b (MyAddMonoid.add c d)) := by
  simp [MyAddMonoid.add_assoc]

theorem neg_add_cancel_thm [MyAddGroup α] (a : α) :
    MyAddMonoid.add (MyAddGroup.neg a) a = MyAddMonoid.zero :=
  MyAddGroup.neg_add_cancel a

theorem double_zero [MyAddMonoid α] :
    double (MyAddMonoid.zero : α) = MyAddMonoid.zero := by
  simp [double, MyAddMonoid.zero_add]

#eval double (5 : Nat)
#eval double (5 : Int)
#eval MyAddMonoid.add (5 : Nat) 7
#eval MyAddGroup.neg (5 : Int)

end MyAdd
