---
spec: color.spec.md
---

## Context

Swift Color is a small cross-platform value library rather than a UI framework adapter. Its contract is numeric: normalization, conversion matrices and transfer functions, textual representations, deterministic transforms, accessibility thresholds, and collection shape. Random palette APIs constrain ranges and spacing but intentionally do not promise repeatable values.

## Related Modules

- Foundation supplies math, formatting, regular expressions, and Codable support.
- Swift DocC generates public documentation independently of pull-request verification.

## Design Decisions

- Store only normalized sRGB and alpha in `Color`; expose other spaces as computed values and value initializers.
- Use D65 LAB as the perceptual conversion and default gradient space.
- Keep all value types Sendable and free of platform UI color dependencies.
- Return nil for textual parse failures and clamp numeric construction/ratios instead of throwing.
- Preserve Linux and macOS native matrices and keep Pages publication independent from Trust.
