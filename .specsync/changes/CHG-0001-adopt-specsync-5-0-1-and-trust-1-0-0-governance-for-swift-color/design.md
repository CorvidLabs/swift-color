---
change: CHG-0001-adopt-specsync-5-0-1-and-trust-1-0-0-governance-for-swift-color
artifact: design
---

# Design

One active `color` contract owns all nine cohesive source files. Eight stable requirements separate core RGBA/protocol semantics, textual/named interchange, HSL/HSV, LAB/LCH, manipulation/blends, accessibility/simulation, palettes/gradients/random values, and repository verification. Test evidence maps every suite group to those requirements.

SpecSync scans `Sources`, governs source/tests/workflows/package/governance/spec paths, and verifies through the Fledge build/test lane. Trust enforces 100% contract coverage, blocking risk, progressive provenance, and disabled Trust-managed Atlas publication.
