---
name: magic-rust-merge-submodules-into-module
description: Consolidate a fragmented Rust module directory by merging all its sub-modules into a single, unified module file, followed by a top-down restructuring.
---

# Magic Rust Merge Sub-Modules Into Module Workflow

This workflow guides the agent to systematically reverse fragmentation in a Rust module by merging all its sub-modules into a single parent module (e.g., `mod.rs`), making the code cohesive and applying a top-down layout.

## 1. Goal

Consolidate a fragmented Rust module directory by:
- Merging all code from sub-modules into the parent module (`mod.rs` or the equivalent root `.rs` file).
- Removing internal `mod` declarations and re-exports.
- Restructuring the newly unified file using a clean, top-down approach.
- Deleting the now-empty sub-module files.

## 2. Process

### Step 1: Full Audit

- Read and understand the target parent module and **every** sub-module within its directory.
- Identify all items (`struct`, `enum`, `trait`, `type` alias, `const`, `static`, free functions, `impl` blocks).
- Identify internal dependencies and internal imports (e.g., `use super::*;`) that will become obsolete when merged into the same file.

### Step 2: Merge Contents into Parent Module

- Cut all data structures, trait definitions, implementations, and free functions from the sub-modules and paste them into the parent module.
- Delete the `mod sub_module_name;` declarations from the parent module.
- Delete any `pub use sub_module_name::*;` or similar re-exports. Since all items are now in the parent module, the `pub` visibility on the items themselves is sufficient to expose them.
- Clean up obsolete internal imports inside the pasted code (e.g., cross-module imports between the formerly separate sub-modules).

### Step 3: Apply Top-Down Ordering

Now that all code is unified in the parent module, apply the top-down restructuring principles:

- Move all data structure definitions (`struct`, `enum`, `type` aliases), constants, and static variables to the top of the file beneath a group banner:
  ```rust
  // ========================================================================
  // Data Structures
  // ========================================================================
  ```
- Order definitions logically using a top-down hierarchy: if type A uses type B in its definition, A appears first. Sort fields of a `struct` and variants of an `enum` alphabetically.
- Any `trait` definitions get their own banner section between data structures and implementations.
  ```rust
  // ========================================================================
  // Traits
  // ========================================================================
  ```
- Group all `impl` blocks (and associated free functions) below the data structures, grouped by the type they implement, separated by distinct banners:
  ```rust
  // ========================================================================
  // Foo Implementations
  // ========================================================================

  impl Foo { ... }

  impl Display for Foo { ... }
  ```
- Sort these implementation groups alphabetically by the data structure's name.

### Step 4: Clean Up Sub-Modules

- Delete the newly emptied sub-module files (`.rs` files) from the file system.
- If the parent module was previously `module_name/mod.rs` and has no remaining sub-directories, consider whether it should be simplified strictly into `module_name.rs` alongside the other files, depending on the user's architectural conventions.

### Step 5: Verification

- // turbo-all
- Run `cargo check` to verify the full project compiles.
- Resolving compiler errors at this stage usually involves fixing broken visibility (items that were `pub(crate)` might now just be private or vice versa) or cleaning up duplicate imports.
- Run `cargo test` to verify no regressions.
- Fix any ordering or borrowing errors before finalizing.

## 3. Constraints

- **Zero Functional Changes & No Deletions:** Do not modify the existing logic or behavior of the code. Every single piece of existing functionality, data structure, auxiliary function, and implementation MUST be preserved in the unified module. Do not delete code.
- **Preserve Public API:** All items that were previously exposed by the parent module through re-exports must remain accessible. Because they are now directly in the parent module, their `pub` visibility should naturally preserve the API.
- **Tests at the bottom:** Any `#[cfg(test)]` modules must remain at the very bottom of the unified file.
