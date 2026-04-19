---
name: magic-rust-refactor-enum-of-structs
description: Restructure Rust module by extracting complex inline struct variants of an enum into standalone structs, and then apply a top-down approach.
---

# Magic Rust Refactor Enum of Struct

This workflow guides the agent to systematically restructure an enum with complex inline struct variants. It extracts these inline structs into standalone struct definitions, improving readability and maintainability, and then restructures the file using a clean, top-down approach.

## 1. Goal

Extract inline struct enum variants into standalone structs, and then restructure the target module to improve readability by declaring all data structures at the top and separating implementations below.

## 2. Process

### Step 1: Extract Enum Variants

- Read and understand the target module completely.
- Locate enums with inline struct variants. For example:
  ```rust
  pub enum MyEnum {
      VariantA { x: i32, y: String },
      VariantB { z: bool },
  }
  ```
- Extract the inline structs into standalone `struct` definitions identically named to the variants (unless instructed otherwise).
  ```rust
  pub enum MyEnum {
      VariantA(VariantA),
      VariantB(VariantB),
  }

  pub struct VariantA { pub x: i32, pub y: String }

  pub struct VariantB { pub z: bool }
  ```
- Ensure fields inside the newly standalone structs are appropriately marked `pub` since they were previously accessible as part of the enum variant.

### Step 2: Refactor Usages

- Update all pattern matching usages of the enum throughout the module, changing from `MyEnum::VariantA { x, y }` to `MyEnum::VariantA(VariantA { x, y })` or `MyEnum::VariantA(inner)` depending on context.
- Update all instantiations of the enum variants to wrap the new struct instances.

### Step 3: Top-Down Restructuring

- Once extracted, apply the top-down restructuring principles:
- Move all data structure definitions (`struct`, `enum`, `type` aliases) to the top of the module beneath a single group banner.
  ```rust
  // ========================================================================
  // Data Structures
  // ========================================================================
  ```
- Order definitions logically using a top-down hierarchy: if `struct`/`enum` A uses `struct`/`enum` B in its definition, then A is at a higher hierarchy and must be defined first. Therefore, the highest-level structures appear at the top, followed progressively by their supporting or auxiliary lower-level types. Always sort the fields of a `struct` and elments of an `enum` alphabetically by name.
  Example:
  ```rust
  pub struct A {
      pub b: B,
  }

  pub struct B {
      pub id: usize,
  }
  ```
- Any `trait` definitions must be placed in their own separate group with a distinct banner.
- Sort multiple trait definitions alphabetically by the trait's name.
  ```rust
  // ========================================================================
  // Traits
  // ========================================================================
  ```
- Group all `impl` blocks (both intrinsic and trait implementations) below the block of data structure definitions.
- Group the implementations by the data structure they implement.
- Sort these implementation groups alphabetically by the data structure's name.
- Separate implementations of different data structures using a distinct comment banner for visual clarity.
  Example block:
  ```rust
  // ========================================================================
  // AssignStmt Implementations
  // ========================================================================

  impl AssignStmt { ... }

  // ========================================================================
  // Block Implementations
  // ========================================================================

  impl Block { ... }
  ```

### Step 4: Verification

- // turbo-all
- After restructuring, verify that the code still compiles successfully.
- Run the cargo check command: `cargo check`
- Wait for the verification to pass. Fix any visibility, ordering, or pattern matching errors caused by the code modification before finalizing the task.

## 3. Constraints

- **Zero Functional Changes:** Do not modify the existing logic or behavior of the code.
- **Tests at the bottom:** Any `#[cfg(test)]` modules must remain at the very bottom of the file.
