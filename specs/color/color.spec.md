---
module: color
version: 1
status: active
files:
  - Sources/Color/Color.swift
  - Sources/Color/Color+Accessibility.swift
  - Sources/Color/Color+HSL.swift
  - Sources/Color/Color+HSV.swift
  - Sources/Color/Color+Hex.swift
  - Sources/Color/Color+LAB.swift
  - Sources/Color/Color+Manipulation.swift
  - Sources/Color/Color+Palette.swift
  - Sources/Color/NamedColor.swift
db_tables: []
depends_on: []
---

# Swift Color

## Purpose

Swift Color is a dependency-free, Sendable Swift value library for clamped sRGB colors. It provides 8-bit and floating-point RGBA construction, HSL/HSV/LAB/LCH conversion, hex/CSS/named-color interchange, manipulation and blend operations, WCAG contrast utilities, color-vision simulations, harmonies, gradients, tonal scales, and random palette generation across Apple platforms and Linux.

## Public API

### Exported Functions

| Export | Description |
|---|---|
| `Color` | Clamped, Codable, Hashable, Sendable sRGB color value. |
| `HSL` | Clamped HSL value with degree hue and normalized saturation/lightness. |
| `HSV` | Clamped HSV/HSB value with degree hue and normalized saturation/value. |
| `LAB` | D65 CIE L*a*b* value with lightness clamped to 0...100. |
| `LCH` | Cylindrical LAB value with nonnegative chroma and degree hue. |
| `NamedColor` | CaseIterable set of 139 standard CSS named colors. |
| `WCAGLevel` | AA and AAA contrast thresholds for normal and large text. |
| `init` | Constructs RGBA, color-space, hex, CSS, and named colors. |
| `red` | Red component or standard red color/name. |
| `green` | Green component or standard green color/name. |
| `blue` | Blue component or standard blue color/name. |
| `alpha` | Normalized alpha component. |
| `black` | Standard black color/name. |
| `white` | Standard white color/name. |
| `yellow` | Standard yellow color/name. |
| `cyan` | Cyan alias for aqua or standard cyan color. |
| `magenta` | Magenta alias for fuchsia or standard magenta color. |
| `clear` | Fully transparent black. |
| `gray` | Standard 50% sRGB gray/name. |
| `red8` | Rounded 8-bit red component. |
| `green8` | Rounded 8-bit green component. |
| `blue8` | Rounded 8-bit blue component. |
| `alpha8` | Rounded 8-bit alpha component. |
| `withAlpha` | Returns the same RGB channels with clamped replacement alpha. |
| `description` | Diagnostic RGBA text, omitting alpha when opaque. |
| `hue` | HSL/HSV/LCH hue in degrees. |
| `saturation` | Normalized HSL/HSV saturation. |
| `lightness` | HSL/LAB/LCH lightness. |
| `value` | Normalized HSV brightness. |
| `a` | LAB green-red component. |
| `b` | LAB blue-yellow component. |
| `chroma` | Nonnegative LCH chroma. |
| `hsl` | Converts sRGB to HSL. |
| `hsv` | Converts sRGB to HSV. |
| `lab` | Converts sRGB through D65 XYZ to LAB. |
| `lch` | Converts LAB to cylindrical LCH. |
| `cssHSL` | Formats CSS hsl/hsla text. |
| `hex` | Formats `#RRGGBB` or `#RRGGBBAA`, or returns a named-color raw hex. |
| `hexValue` | Formats hex without the leading hash. |
| `css` | Formats CSS rgb/rgba text. |
| `deltaE` | Computes CIE76 Euclidean difference in LAB. |
| `mixLAB` | Interpolates in LAB with a clamped ratio. |
| `lighten` | Adds HSL lightness up to one. |
| `darken` | Subtracts HSL lightness down to zero. |
| `saturate` | Adds HSL saturation up to one. |
| `desaturate` | Subtracts HSL saturation down to zero. |
| `grayscale` | Applies the documented weighted sRGB grayscale formula. |
| `inverted` | Inverts all RGB channels and preserves alpha. |
| `complement` | Rotates hue by 180 degrees. |
| `adjustHue` | Rotates hue with wrapping into 0..<360. |
| `mix` | Linearly interpolates RGBA with a clamped ratio. |
| `tint` | Mixes toward white. |
| `shade` | Mixes toward black. |
| `multiply` | Applies component multiplication and preserves base alpha. |
| `screen` | Applies inverse multiplication and preserves base alpha. |
| `overlay` | Applies multiply/screen per base-channel midpoint and preserves base alpha. |
| `aa` | WCAG AA level. |
| `aaa` | WCAG AAA level. |
| `normalTextRatio` | Returns 4.5 for AA and 7 for AAA. |
| `largeTextRatio` | Returns 3 for AA and 4.5 for AAA. |
| `luminance` | Computes WCAG relative luminance. |
| `contrastRatio` | Computes symmetric contrast from 1:1 through 21:1. |
| `isAccessible` | Compares contrast with level/text-size threshold. |
| `textColor` | Chooses black or white from the supplied background luminance. |
| `contrastingTextColor` | Chooses black or white for this color as background. |
| `adjustedForAccessibility` | Searches HSL lightness in 0.01 steps and falls back to black/white. |
| `simulatedProtanopia` | Applies the documented red-blind matrix. |
| `simulatedDeuteranopia` | Applies the documented green-blind matrix. |
| `simulatedTritanopia` | Applies the documented blue-blind matrix. |
| `complementary` | Returns self and the 180-degree complement. |
| `triadic` | Returns hue offsets 0, 120, and 240. |
| `tetradic` | Returns hue offsets 0, 90, 180, and 270. |
| `splitComplementary` | Returns hue offsets 0, 150, and 210. |
| `analogous` | Returns the requested count at equal configurable hue angles. |
| `gradient` | Produces inclusive RGB or LAB endpoints; one or fewer steps returns self. |
| `multiGradient` | Joins per-segment gradients without duplicate interior stops. |
| `tints` | Produces an RGB gradient to white. |
| `shades` | Produces an RGB gradient to black. |
| `tonalScale` | Produces a black-through-color-to-white scale. |
| `random` | Generates random normalized RGBA with caller-selected alpha. |
| `randomWithHue` | Generates a color at a fixed hue within saturation/lightness ranges. |
| `distinctPalette` | Spaces random-start hues by the golden ratio. |
| `color` | Converts a CSS named-color case to `Color`. |
| `named` | Converts a `NamedColor` to `Color`. |
| `indianRed` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `lightCoral` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `salmon` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `darkSalmon` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `lightSalmon` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `crimson` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `fireBrick` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `darkRed` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `pink` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `lightPink` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `hotPink` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `deepPink` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `mediumVioletRed` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `paleVioletRed` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `coral` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `tomato` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `orangeRed` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `darkOrange` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `orange` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `gold` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `lightYellow` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `lemonChiffon` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `lightGoldenrodYellow` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `papayaWhip` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `moccasin` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `peachPuff` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `paleGoldenrod` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `khaki` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `darkKhaki` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `lavender` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `thistle` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `plum` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `violet` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `orchid` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `fuchsia` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `mediumOrchid` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `mediumPurple` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `rebeccaPurple` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `blueViolet` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `darkViolet` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `darkOrchid` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `darkMagenta` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `purple` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `indigo` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `slateBlue` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `darkSlateBlue` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `mediumSlateBlue` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `greenYellow` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `chartreuse` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `lawnGreen` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `lime` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `limeGreen` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `paleGreen` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `lightGreen` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `mediumSpringGreen` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `springGreen` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `mediumSeaGreen` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `seaGreen` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `forestGreen` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `darkGreen` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `yellowGreen` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `oliveDrab` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `olive` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `darkOliveGreen` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `mediumAquamarine` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `darkSeaGreen` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `lightSeaGreen` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `darkCyan` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `teal` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `aqua` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `lightCyan` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `paleTurquoise` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `aquamarine` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `turquoise` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `mediumTurquoise` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `darkTurquoise` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `cadetBlue` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `steelBlue` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `lightSteelBlue` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `powderBlue` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `lightBlue` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `skyBlue` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `lightSkyBlue` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `deepSkyBlue` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `dodgerBlue` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `cornflowerBlue` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `royalBlue` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `mediumBlue` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `darkBlue` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `navy` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `midnightBlue` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `cornsilk` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `blanchedAlmond` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `bisque` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `navajoWhite` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `wheat` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `burlyWood` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `tan` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `rosyBrown` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `sandyBrown` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `goldenrod` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `darkGoldenrod` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `peru` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `chocolate` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `saddleBrown` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `sienna` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `brown` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `maroon` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `snow` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `honeyDew` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `mintCream` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `azure` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `aliceBlue` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `ghostWhite` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `whiteSmoke` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `seaShell` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `beige` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `oldLace` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `floralWhite` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `ivory` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `antiqueWhite` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `linen` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `lavenderBlush` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `mistyRose` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `gainsboro` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `lightGray` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `silver` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `darkGray` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `dimGray` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `lightSlateGray` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `slateGray` | CSS named-color case whose raw value is its six-digit sRGB hex code. |
| `darkSlateGray` | CSS named-color case whose raw value is its six-digit sRGB hex code. |

## Invariants

1. Every `Color` channel is clamped to 0...1 at construction; HSL/HSV saturation and lightness/value, LAB/LCH lightness, and nonnegative LCH chroma are likewise normalized by their value initializers.
2. Floating-point and 8-bit construction, access, Codable round trips, equality, hashing, descriptions, and common constants preserve the documented RGBA value semantics.
3. HSL and HSV conversions handle achromatic colors, all six hue sectors, alpha preservation, and round trips; hue rotation used by operations is wrapped to 0..<360.
4. LAB conversion uses D65 sRGB↔XYZ matrices and piecewise transfer functions; LCH is the cylindrical LAB representation, Delta E is CIE76, and LAB mixing clamps its ratio.
5. Hex parsing accepts 3/4/6/8 digits with optional `#` or `0x`; CSS parsing accepts integer rgb/rgba syntax. Invalid lengths, digits, formats, or names return nil.
6. Manipulation, blending, simulations, conversion, interpolation, and palette operations preserve alpha except where an explicit interpolated or caller-selected alpha is part of the operation.
7. WCAG thresholds are AA 4.5/3.0 and AAA 7.0/4.5; luminance and contrast follow the implemented WCAG transfer function, and accessibility adjustment returns an accessible result or the black/white fallback.
8. NamedColor contains exactly 139 CSS names; fuchsia/magenta and aqua/cyan are aliases, every raw value is a six-digit hex value, and string lookup is case-insensitive over case names and raw values.
9. Gradients include endpoints, avoid duplicate multi-stop boundaries, and preserve requested counts for valid inputs; harmonies use their documented hue offsets.
10. All public value types are Sendable, all source is platform-neutral Foundation/Swift code, and native verification never publishes documentation or a release.

## Behavioral Examples

```text
Given an out-of-range floating-point or 8-bit component
When Color is initialized
Then each stored channel is clamped to 0...1 and 8-bit access rounds to 0...255.

Given a Color converted to HSL, HSV, LAB, or LCH
When the matching initializer reconstructs it
Then RGB and alpha round-trip within the tested color-space tolerance.

Given two endpoint colors and five gradient steps
When gradient is requested
Then five colors include both endpoints and use LAB interpolation by default.

Given a foreground/background pair
When WCAG accessibility is evaluated
Then contrast is compared with the selected AA/AAA normal/large-text threshold.
```

## Error Cases

| Condition | Behavior |
|---|---|
| Invalid hex length or non-hex digits | `Color(hex:)` returns nil. |
| Unsupported CSS syntax or missing numeric channels | `Color(css:)` returns nil. |
| Unknown CSS color name | `Color(name:)` returns nil. |
| Out-of-range components or interpolation ratios | Values are clamped at the documented boundary. |
| One or fewer gradient steps | A one-element array containing the start color is returned. |
| Already-accessible foreground | Accessibility adjustment returns the original color. |
| Adjustment search cannot find a hue-preserving result | Black or white is selected from background luminance. |

## Dependencies

- Swift 6 standard library and Foundation math, formatting, regular-expression, and Codable facilities.
- Swift DocC plugin is development-only for the independent documentation workflow.
- No runtime package dependency.

## Change Log

| Version | Date | Changes |
|---|---|---|
| 1 | 2026-07-13 | Recorded the complete nine-file public contract during SpecSync 5.0.1 and Trust 1.0.0 adoption. |
