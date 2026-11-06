/-
# `IO`

`IO α` is a monad for computations that interact with the outside world.
A Lean program's entry point is a value `main : IO Unit`.
-/
import Std

namespace IOExamples

def greet (name : String) : IO Unit :=
  IO.println s!"Hello, {name}!"

def readToolchain : IO String :=
  IO.FS.readFile "lean-toolchain"

def main : IO Unit := do
  IO.println "Hello from Lean 4!"
  let name := "world"
  IO.println s!"Hello, {name}!"
  IO.print "This line has no newline...\n"
  let contents ← readToolchain
  IO.println s!"The toolchain file has {contents.length} characters."

/-! ## Pure helpers used by IO code -/

def formatLine (n : Nat) (text : String) : String :=
  s!"{n}: {text}"

def printNumbered (lines : List String) : IO Unit := do
  let mut i := 1
  for line in lines do
    IO.println (formatLine i line)
    i := i + 1

end IOExamples
