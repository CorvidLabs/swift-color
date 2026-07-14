---
spec: color.spec.md
---

## Test Plan

| Requirement | Evidence |
|---|---|
| REQ-color-001 | RGB Double/8-bit Initialization, RGB Clamping, 8-bit Component Access, Static Constants, withAlpha, Color Core, Equatable, Hashable, Codable, CustomStringConvertible, Sendable, and Alpha Preservation suites. |
| REQ-color-002 | Hex String Parsing/Output, CSS RGB/HSL Format, Named Color Creation/Aliases/String Lookup/Categories/Consistency suites. |
| REQ-color-003 | HSL Conversion, HSV Conversion, and Cross-Space Conversion suites plus conversion edge cases. |
| REQ-color-004 | LAB Conversion, LCH Conversion, perceptual gradient, Delta E, and cross-space suites. |
| REQ-color-005 | Manipulation, Manipulation Edge Cases, Blend Modes, Blend Mode Edge Cases, and Grayscale Edge Cases suites. |
| REQ-color-006 | Accessibility, Accessibility Edge Cases, WCAGLevel, Color Blindness Simulation, and Color Blindness Edge Cases suites. |
| REQ-color-007 | Palettes, Palette Edge Cases, Gradients Extended, Color Harmonies Extended, and Random Colors suites. |
| REQ-color-008 | `fledge lanes run verify`, strict SpecSync 100%, four-agent status, Trust doctor/verify, hosted Ubuntu/macOS, CodeQL, and immutable Trust checks. |

The complete native suite contains 351 tests in 51 suites. It is deterministic except for random APIs, whose assertions validate ranges, alpha, counts, and uniqueness rather than exact generated values.
