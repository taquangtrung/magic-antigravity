---
name: magic-rust-refactor-structure-into-submodules
description: Restructure a Rust module and all its sub-modules into a well-organized layout by grouping related code into sub-modules and keeping the main code in the parent module.
---

# Magic Rust Refactor Structured Submodules Workflow

This workflow guides the agent to systematically restructure a Rust module directory so that code is logically grouped into focused sub-modules, while the parent module retains only the primary data structures, re-exports, and core orchestration logic.

## 1. Goal

Reorganize a target Rust module (directory) and all its sub-modules so that:
- Each sub-module holds a cohesive group of related data structures together with **all** their implementations (`impl` blocks, `Display`, `From`, etc.).
- The parent module (`mod.rs` or the root file) contains only the primary/top-level data structures, their implementations, and re-exports from sub-modules.
- Secondary or auxiliary data structures are factored out into dedicated sub-modules, grouped by relatedness.
- The public API surface remains unchanged through re-exports.

## 2. Process

### Step 1: Full Audit

- Read and understand the target module and **every** sub-module within it.
- Catalog every item: `struct`, `enum`, `trait`, `type` alias, `const`, `static`, free functions, `impl` blocks, and `mod` declarations.
- For each item, note:
  - Its visibility (`pub`, `pub(crate)`, private).
  - Which other items it depends on or is depended upon by.
  - Which group of related data structures it belongs to.

### Step 2: Design the Module Layout

- Propose a module tree where related data structures are grouped into sub-modules.
- Apply these principles:

  **What stays in the parent module (`mod.rs`):**
  - The primary/top-level data structures that define the module's identity, along with all their `impl` blocks. The main data structure of a module must always live in `mod.rs` — never extract it into a sub-module that duplicates the parent's name. For example, `Lowerer` stays in `lowering/mod.rs`, not `lowering/lower.rs`.
  - `mod` declarations and `pub use` re-exports.
  - Minimal glue logic that ties sub-modules together (if any).

  **What moves to sub-modules:**
  - Groups of related secondary data structures, each accompanied by **all** of their implementations (`impl` blocks, `Display`, `From`, trait impls, etc.). **Do not split the implementation of a data structure across multiple modules.** A data structure and all its behavior must live in the same file — never spread a type's definition and its `impl` blocks into different files.
  - Free functions closely associated with the data structures in that sub-module.

- Name sub-modules after the data structures or the domain concept they represent. Good names: `expr`, `stmt`, `constraint`, `value`, `block`, `instr`. Bad names: `helpers`, `utils`, `misc`, `display`, `conversion`.
- **Never create a sub-module whose name duplicates the parent module's name.** For example, inside `lowering/`, do not create `lowering/lower.rs` or `lowering/lowering.rs`. The main logic belongs in `lowering/mod.rs`.

- Present the proposed layout to the user as a tree visualization before proceeding. Example:
  ```
  cir/
  ├── mod.rs          — Program and Func structs and their impls; mod/re-export declarations
  ├── expr.rs         — Expr enum, ExprKind, and all their impls
  ├── stmt.rs         — Stmt, AssignStmt, IfStmt, and all their impls
  └── constraint.rs   — Constraint, ConstraintKind, and all their impls
  ```

### Step 3: Execute the Restructuring

For each sub-module to create or reorganize:

1. **Create the sub-module file** with the items that belong there.
2. **Add `mod` and `pub use`** declarations in the parent module.
3. **Update imports** in the moved code so that all references resolve correctly. Prefer `use super::*` or explicit `use super::TypeName` at the top of each sub-module for items from the parent.
4. **Update external references** across the codebase that import from this module. If the public API is preserved through re-exports, external code should not need changes.

Work one sub-module at a time. After each sub-module extraction, run `cargo check` to catch breakage early.

### Step 4: Apply Top-Down Ordering Within Each File

After all extractions are complete, apply the top-down restructuring principles within every affected file:

- Move all data structure definitions (`struct`, `enum`, `type` aliases) to the top of the file beneath a group banner:
  ```rust
  // ========================================================================
  // Data Structures
  // ========================================================================
  ```
- Order definitions logically using a top-down hierarchy: if type A uses type B in its definition, A appears first. Sort fields of a `struct` and variants of an `enum` alphabetically.
- Place all `impl` blocks below the data structures, grouped by the type they implement, separated by banners:
  ```rust
  // ========================================================================
  // Foo Implementations
  // ========================================================================

  impl Foo { ... }

  impl Display for Foo { ... }
  ```
- Sort implementation groups alphabetically by the type's name.
- Any `trait` definitions get their own banner section between data structures and implementations.

### Step 5: Clean Up

- Remove empty or redundant files.
- Remove redundant, noisy, or legacy comments. Keep meaningful docstrings intact.
- Ensure `mod` declarations and `pub use` re-exports in the parent module are sorted alphabetically.
- Verify that no circular dependencies were introduced between sub-modules.

### Step 6: Verification

- // turbo-all
- Run `cargo check` to verify the full project compiles.
- Run `cargo test` to verify no regressions.
- Fix any visibility, import, or ordering errors before finalizing.

## 3. Constraints

- **Zero Functional Changes & No Deletions:** Do not modify the existing logic or behavior of the code. Every single piece of existing functionality, data structure, auxiliary function, and implementation MUST be preserved somewhere in the new layout. Do not delete code.
- **Preserve Public API:** All items that were previously `pub` must remain accessible at the same module path through re-exports, unless the user explicitly approves API path changes.
- **Tests at the bottom:** Any `#[cfg(test)]` modules must remain at the very bottom of the file they belong to.
- **Cohesive sub-modules:** Each sub-module groups related data structures with all their implementations. **Do not split the implementation of a data structure across multiple modules.** Do not create catch-all modules like `helpers.rs` or `utils.rs`.
