# SwiftColor

[![CI](https://img.shields.io/github/actions/workflow/status/CorvidLabs/swift-color/ci.yml?label=CI&branch=main)](https://github.com/CorvidLabs/swift-color/actions/workflows/ci.yml)
[![License](https://img.shields.io/github/license/CorvidLabs/swift-color)](https://github.com/CorvidLabs/swift-color/blob/main/LICENSE)
[![Version](https://img.shields.io/github/v/release/CorvidLabs/swift-color)](https://github.com/CorvidLabs/swift-color/releases)

A pure Swift library for color manipulation, conversion, and palette generation.

## Features

- **Multiple Color Spaces** - RGB, HSL, HSV, LAB, LCH
- **140 CSS Named Colors** - All standard web colors
- **Color Manipulation** - lighten, darken, saturate, mix, blend
- **WCAG Accessibility** - Contrast ratios, AA/AAA compliance
- **Palette Generation** - Gradients, harmonies, distinct colors
- **Zero Dependencies** - Pure Swift, works on all platforms

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/CorvidLabs/swift-color.git", from: "0.1.0")
]
```

Then add the target dependency:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "Color", package: "swift-color")
    ]
)
```

## Quick Start

```swift
import Color

// Create colors
let red = Color(hex: "#FF0000")!
let blue = Color(r: 0.0, g: 0.0, b: 1.0)
let coral = Color.named(.coral)

// Convert between color spaces
let hsl = red.hsl  // HSL(h: 0, s: 1.0, l: 0.5)
let lab = red.lab  // LAB(l: 53.2, a: 80.1, b: 67.2)

// Manipulate colors
let light = red.lighten(by: 0.2)
let muted = red.desaturate(by: 0.3)
let purple = red.mix(with: blue, ratio: 0.5)

// Check accessibility
let ratio = red.contrastRatio(with: .white)  // 4.0
let passes = red.isAccessible(on: .white, level: .aa)  // false
let textColor = red.contrastingTextColor  // .white

// Generate palettes
let gradient = red.gradient(to: blue, steps: 5)
let triadic = red.triadic  // [red, green, blue]
let palette = Color.distinctPalette(count: 10)
```

## Color Spaces

| Space | Description |
|-------|-------------|
| RGB | Red, Green, Blue (0.0-1.0) |
| HSL | Hue (0-360), Saturation, Lightness |
| HSV | Hue (0-360), Saturation, Value |
| LAB | CIE L*a*b* perceptually uniform |
| LCH | Cylindrical LAB (Lightness, Chroma, Hue) |

## Manipulation Methods

```swift
color.lighten(by: 0.2)      // Increase lightness
color.darken(by: 0.2)       // Decrease lightness
color.saturate(by: 0.2)     // Increase saturation
color.desaturate(by: 0.2)   // Decrease saturation
color.adjustHue(by: 120)    // Rotate hue
color.complement            // Opposite on color wheel
color.inverted              // RGB inverse
color.grayscale             // Luminance-based gray
color.mix(with: other)      // Blend two colors
color.mixLAB(with: other)   // Perceptual blend
```

## Accessibility (WCAG)

```swift
// Contrast ratio (1:1 to 21:1)
let ratio = foreground.contrastRatio(with: background)

// Check AA/AAA compliance
foreground.isAccessible(on: background, level: .aa)
foreground.isAccessible(on: background, level: .aaa, largeText: true)

// Auto-select readable text color
let textColor = background.contrastingTextColor

// Adjust color to meet requirements
let accessible = color.adjustedForAccessibility(on: background)

// Color blindness simulation
let protanopia = color.simulatedProtanopia
let deuteranopia = color.simulatedDeuteranopia
```

## Palettes & Harmonies

```swift
// Color harmonies
color.complementary       // [color, opposite]
color.triadic            // 3 evenly spaced
color.tetradic           // 4 evenly spaced
color.splitComplementary // [color, 2 adjacent to opposite]
color.analogous()        // Adjacent colors

// Gradients
color.gradient(to: end, steps: 10)
color.multiGradient(through: [c1, c2, c3], stepsPerSegment: 5)

// Tonal scales
color.tints(count: 5)    // To white
color.shades(count: 5)   // To black
color.tonalScale(count: 9)  // Black -> color -> white

// Random colors
Color.random()
Color.distinctPalette(count: 10)  // Visually distinct
```

## Named Colors

All 140 standard CSS colors:

```swift
Color.named(.coral)
Color.named(.steelBlue)
Color.named(.rebeccaPurple)

// Or by string
Color(name: "coral")
```

## License

MIT License - see [LICENSE](LICENSE) for details.
