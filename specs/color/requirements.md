---
spec: color.spec.md
---

## Requirements

### REQ-color-001
The library SHALL represent RGBA as clamped normalized values with equivalent floating-point/8-bit construction, rounded 8-bit access, stable constants, alpha replacement, Codable, Hashable, Sendable, and diagnostic-description semantics.

Acceptance Criteria
- Core, RGB, protocol, clamping, alpha, constant, concurrency, Codable, Hashable, and description suites pass.

### REQ-color-002
The library SHALL parse and format supported hex, CSS rgb/rgba, CSS hsl/hsla, and case-insensitive CSS named-color representations while rejecting invalid text with nil.

Acceptance Criteria
- Hex/CSS suites and all named-color suites pass, including 139 cases and both aliases.

### REQ-color-003
The library SHALL convert between sRGB, HSL, and HSV across achromatic and all hue-sector cases while preserving alpha and documented normalization.

Acceptance Criteria
- HSL, HSV, and cross-space conversion suites pass their primary, boundary, clamping, and round-trip cases.

### REQ-color-004
The library SHALL convert sRGB through D65 XYZ to LAB/LCH, reconstruct colors, compute CIE76 Delta E, and interpolate LAB values with clamped ratios.

Acceptance Criteria
- LAB, LCH, cross-space, Delta E, and perceptual-gradient tests pass within their declared tolerances.

### REQ-color-005
The library SHALL implement documented HSL manipulation, RGB mixing/tint/shade, grayscale/inversion, and multiply/screen/overlay formulas while preserving alpha as specified.

Acceptance Criteria
- Manipulation, blend-mode, alpha-preservation, grayscale, and edge-case suites pass.

### REQ-color-006
The library SHALL implement WCAG luminance, contrast, AA/AAA thresholds, contrasting text selection, accessibility adjustment, and the three documented color-vision simulation matrices.

Acceptance Criteria
- Accessibility, WCAGLevel, color-blindness, contrast-boundary, and alpha-preservation suites pass.

### REQ-color-007
The library SHALL generate documented harmonies, inclusive RGB/LAB gradients, deduplicated multi-stop gradients, tint/shade/tonal scales, and bounded random palettes.

Acceptance Criteria
- Palette, harmony, gradient, count, endpoint, uniqueness, and random-range suites pass.

### REQ-color-008
The repository SHALL govern all nine source files at 100% SpecSync file and line coverage and retain blocking Swift build/test verification on Linux and macOS without invoking documentation deployment.

Acceptance Criteria
- Released SpecSync 5.0.1 reports every parsed export and 1,730/1,730 LOC.
- All 351 tests across 51 suites pass locally and on the preserved hosted matrices.

## Out of Scope

- Platform UI color bridging, ICC profiles, wide-gamut/HDR spaces, deterministic random seeds, documentation deployment, and release publication.
