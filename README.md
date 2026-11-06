# Lean 4 Examples

A collection of small, self-contained Lean 4 examples covering functional
programming and theorem proving. Every topic lives in its own file under
[`Lean4Examples/`](Lean4Examples), and [`Lean4Examples.lean`](Lean4Examples.lean)
imports all of them.

The project uses only Lean 4 and its bundled `Std` library. **Mathlib is not
required.**

## Requirements

- Lean 4.22.0 (pinned by [`lean-toolchain`](lean-toolchain))
- Lake, which ships with Lean

## Build and run

```sh
lake build
```

The `#eval` commands in the examples print their results during the build.
To run the IO example:

```sh
lake exe examples
```

To check a single topic file:

```sh
lake env lean Lean4Examples/Basics.lean
```

## Topics covered

### Functional programming

| # | File | Topics |
|---|------|--------|
| 1 | [`Basics.lean`](Lean4Examples/Basics.lean) | Terms, types, universes, definitions, `let`, `if`, `match`, `#check`, `#eval` |
| 2 | [`Functions.lean`](Lean4Examples/Functions.lean) | Currying, partial application, higher-order functions, composition, anonymous functions, implicit and named arguments |
| 3 | [`InductiveTypes.lean`](Lean4Examples/InductiveTypes.lean) | `inductive` declarations, enumerations, recursive trees, a JSON-like data type |
| 4 | [`PatternMatching.lean`](Lean4Examples/PatternMatching.lean) | Function equations, nested patterns, `Option` matching, as-patterns, patterns in `let` and `fun` |
| 5 | [`Structures.lean`](Lean4Examples/Structures.lean) | Records, default fields, record update, `extends`, structures with proof fields |
| 6 | [`TypeClasses.lean`](Lean4Examples/TypeClasses.lean) | Classes, instances, higher-kinded classes, default methods and laws |
| 7 | [`DependentTypes.lean`](Lean4Examples/DependentTypes.lean) | Subtypes, `Fin`, sigma types, length-indexed vectors |
| 8 | [`OptionExcept.lean`](Lean4Examples/OptionExcept.lean) | `Option`, `Except`, safe division, lookup chains, error messages |
| 9 | [`Lists.lean`](Lean4Examples/Lists.lean) | List API, `map`/`filter`/`fold`, recursion on lists, induction proofs |
| 10 | [`Arrays.lean`](Lean4Examples/Arrays.lean) | Array literals, indexing, `push`, `set!`, `map`, `foldl`, safe indexing, `push` lemma |
| 11 | [`Strings.lean`](Lean4Examples/Strings.lean) | String operations, interpolation, predicates, slicing, recursion over characters |
| 12 | [`Collections.lean`](Lean4Examples/Collections.lean) | `HashMap`, `HashSet`, `TreeMap`, ordered maps, word counting |
| 13 | [`FunctorsMonads.lean`](Lean4Examples/FunctorsMonads.lean) | `Functor`, `Applicative`, `Monad`, a custom `Box` monad, `StateM` |
| 14 | [`DoNotation.lean`](Lean4Examples/DoNotation.lean) | `do` notation for `Option`, `Except`, and `Id.run`, mutable-looking loops |
| 15 | [`IO.lean`](Lean4Examples/IO.lean) | `IO` actions, `main`, printing, reading a file, loops in `IO` |
| 16 | [`Recursion.lean`](Lean4Examples/Recursion.lean) | Structural recursion, `termination_by`, custom inductive recursion, mutual recursion |
| 17 | [`TailRecursion.lean`](Lean4Examples/TailRecursion.lean) | Accumulator arguments, tail-recursive `sum`/`reverse`/`map`, Fibonacci, `foldl` vs `foldr` |
| 18 | [`Deriving.lean`](Lean4Examples/Deriving.lean) | Deriving `BEq`, `Repr`, `Inhabited`, `DecidableEq`, `Ord`, `Hashable`; custom `Repr` |
| 19 | [`Laziness.lean`](Lean4Examples/Laziness.lean) | `Thunk`, infinite lazy lists, infinite sequences as functions, the core `Stream` class |
| 20 | [`Macros.lean`](Lean4Examples/Macros.lean) | `syntax`, `macro_rules`, `macro`, custom notation, hygiene, `MacroM` |

### Theorem proving

| # | File | Topics |
|---|------|--------|
| 21 | [`Propositions.lean`](Lean4Examples/Propositions.lean) | `True`, `False`, conjunction, disjunction, negation, `↔` |
| 22 | [`Implication.lean`](Lean4Examples/Implication.lean) | Implication as a function, `intro`, `apply`, `exact`, `have`, currying |
| 23 | [`Equality.lean`](Lean4Examples/Equality.lean) | `rfl`, symmetry, transitivity, rewriting, `subst`, `congrArg`, `calc` |
| 24 | [`Quantifiers.lean`](Lean4Examples/Quantifiers.lean) | Universal and existential quantifiers, witnesses, `obtain`, `rintro` |
| 25 | [`Induction.lean`](Lean4Examples/Induction.lean) | Induction on `Nat`, lists, and a custom tree type |
| 26 | [`StrongInduction.lean`](Lean4Examples/StrongInduction.lean) | Strong induction, well-founded recursion, `termination_by`, minimal elements |
| 27 | [`Tactics.lean`](Lean4Examples/Tactics.lean) | Survey of `rfl`, `decide`, `simp`, `omega`, `trivial`, `assumption`, `intro`, `apply`, `exact`, `constructor`, `cases`, `contradiction`, `exfalso`, `by_cases`, `byContradiction` |
| 28 | [`Simplification.lean`](Lean4Examples/Simplification.lean) | `simp`, `simp only`, custom `@[simp]` lemmas, local hypotheses, `rw` |
| 29 | [`Decidability.lean`](Lean4Examples/Decidability.lean) | `Decidable`, `decide`, proof-producing `if`, `split`, custom instances |
| 30 | [`ClassicalLogic.lean`](Lean4Examples/ClassicalLogic.lean) | Excluded middle, double-negation elimination, Peirce's law, classical choice |
| 31 | [`Sets.lean`](Lean4Examples/Sets.lean) | Predicate-based sets, membership, subsets, union, intersection, extensionality |
| 32 | [`Relations.lean`](Lean4Examples/Relations.lean) | Reflexive/symmetric/transitive relations, equivalence relations, partial orders, converse, composition |
| 33 | [`NatArithmetic.lean`](Lean4Examples/NatArithmetic.lean) | Natural number lemmas, `omega`, nonlinear inequalities, divisibility, parity |
| 34 | [`Integers.lean`](Lean4Examples/Integers.lean) | Integer arithmetic, order, negation, casts from `Nat` |
| 35 | [`Algebra.lean`](Lean4Examples/Algebra.lean) | Custom additive monoid and group classes, instances, generic theorems |
| 36 | [`ProofsAboutPrograms.lean`](Lean4Examples/ProofsAboutPrograms.lean) | Correctness proofs for list sum, reverse, and factorial |

## Layout

```text
.
├── lean-toolchain
├── lakefile.toml
├── Lean4Examples.lean      -- imports every topic
├── Main.lean               -- runnable IO entry point
├── README.md
└── Lean4Examples/
    ├── Basics.lean
    ├── Functions.lean
    ├── ...
    └── ProofsAboutPrograms.lean
```
