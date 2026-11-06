/-
# Decidability

A proposition `p` is decidable when Lean can decide whether it holds. This
is what makes `if` on propositions, `decide`, and `by_cases` work.
-/
import Std

#check Decidable
#check decide

/-! ## Deciding concrete propositions -/

example : decide (2 + 2 = 4) = true := rfl
example : decide (2 + 2 = 5) = false := rfl

def isEvenBool (n : Nat) : Bool :=
  n % 2 == 0

#eval isEvenBool 10
#eval isEvenBool 7

/-! ## `if` with a proof-producing hypothesis -/

def checkEven (n : Nat) : String :=
  if _h : n % 2 = 0 then
    s!"{n} is even"
  else
    s!"{n} is odd"

#eval checkEven 10
#eval checkEven 7

/-! ## `Decidable.em` -/

example (p : Prop) [Decidable p] : p ∨ ¬p :=
  Decidable.em p

example (n : Nat) : n = 0 ∨ n ≠ 0 := by
  exact Decidable.em (n = 0)

/-! ## Case splitting -/

example (n : Nat) : (if n == 0 then 1 else 2) = 1 ∨
    (if n == 0 then 1 else 2) = 2 := by
  split <;> simp_all

/-! ## Custom decidable instances -/

def IsSmall (n : Nat) : Prop :=
  n < 10

instance (n : Nat) : Decidable (IsSmall n) := by
  unfold IsSmall
  infer_instance

example : decide (IsSmall 5) = true := rfl
example : decide (IsSmall 15) = false := rfl
