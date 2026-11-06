/-
# Dependent types

A dependent type mentions a *value*. Subtypes, `Fin`, and sigma types
are the basic building blocks for precise specifications.
-/
import Std

/-! ## Subtypes -/

def Positive : Type :=
  { n : Nat // n > 0 }

def one : Positive :=
  ⟨1, by omega⟩

def Positive.succ (p : Positive) : Positive :=
  ⟨p.val + 1, by omega⟩

#eval one.val
#eval (Positive.succ one).val

/-! ## `Fin`: natural numbers below a bound -/

def Fin.zero {n : Nat} : Fin (n + 1) :=
  ⟨0, by omega⟩

#eval (Fin.zero : Fin 5).val
#eval ((3 : Fin 10).val)

def safeGet (xs : List α) (i : Fin xs.length) : α :=
  xs.get i

#eval safeGet [10, 20, 30] ⟨1, by decide⟩

/-! ## Sigma types: a value paired with a type depending on it -/

def dependentPair : (n : Nat) × Fin (n + 1) :=
  ⟨3, ⟨0, by omega⟩⟩

#eval dependentPair.1
#eval dependentPair.2.val

/-! ## Length-indexed vectors -/

def Vec (α : Type) (n : Nat) : Type :=
  { l : List α // l.length = n }

def vnil {α : Type} : Vec α 0 :=
  ⟨[], rfl⟩

def vcons {α : Type} (x : α) {n : Nat} (v : Vec α n) : Vec α (n + 1) :=
  ⟨x :: v.val, by simp [v.property]⟩

def vhead {α : Type} {n : Nat} (v : Vec α (n + 1)) : α :=
  v.val.get ⟨0, by
    have h : v.val.length = n + 1 := v.property
    omega⟩

#eval vhead (vcons 10 (vnil : Vec Nat 0))
#eval (vcons 1 (vcons 2 (vnil : Vec Nat 0))).val
