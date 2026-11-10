import Std

def sum : List Nat -> Nat
  | [] => 0
  | x :: xs => x + sum xs

#eval sum [1, 2, 3]

/- sum [] = 0 -/
theorem sum_nil : sum [] = 0 := by rfl

/- sum [x] = x -/
theorem sum_single: sum [x] = x := by rfl

/- sum xs + sum ys = sum (xs ++ ys) -/
theorem sum_append (xs ys : List Nat) : sum (xs ++ ys) = sum xs + sum ys := by
  induction xs with
  | nil => simp [sum]
  | cons x xs ih =>
    simp [sum, ih]
    omega

def swap {α β : Type} : α × β → β × α
  | (a, b) => (b, a)

theorem swap_swap {α β : Type} : ∀ p : α × β, swap (swap p) = p
  | (a, b) => rfl

def transfer (src dst amt: Nat) : Nat × Nat := (src - amt, dst + amt)

theorem transfer_preserves_total
  (src dst amt : Nat)
  (h : amt <= src) :
  (transfer src dst amt).1 + (transfer src dst amt).2 = src + dst := by
  simp [transfer]
  omega
