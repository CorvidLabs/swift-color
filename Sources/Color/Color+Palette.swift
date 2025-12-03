import Foundation

// MARK: - Color Harmonies

extension Color {
    /**
     Returns complementary colors (this color and its opposite).

     ```swift
     let harmony = Color.red.complementary
     // Returns [red, cyan]
     ```
     */
    public var complementary: [Color] {
        [self, complement]
    }

    /**
     Returns triadic colors (three evenly spaced colors).

     ```swift
     let harmony = Color.red.triadic
     // Returns [red, green, blue]
     ```
     */
    public var triadic: [Color] {
        [
            self,
            adjustHue(by: 120),
            adjustHue(by: 240)
        ]
    }

    /**
     Returns tetradic colors (four evenly spaced colors).

     ```swift
     let harmony = Color.red.tetradic
     // Returns [red, yellow-green, cyan, blue-violet]
     ```
     */
    public var tetradic: [Color] {
        [
            self,
            adjustHue(by: 90),
            adjustHue(by: 180),
            adjustHue(by: 270)
        ]
    }

    /**
     Returns split-complementary colors (this color and two adjacent to its complement).

     ```swift
     let harmony = Color.red.splitComplementary
     // Returns [red, teal, blue-green]
     ```
     */
    public var splitComplementary: [Color] {
        [
            self,
            adjustHue(by: 150),
            adjustHue(by: 210)
        ]
    }

    /**
     Returns analogous colors (adjacent colors on the wheel).

     - Parameter count: Number of colors to return (default 3)
     - Parameter angle: Degrees between each color (default 30)
     - Returns: Array of analogous colors

     ```swift
     let harmony = Color.red.analogous()
     // Returns [red-orange, red, red-violet]
     ```
     */
    public func analogous(count: Int = 3, angle: Double = 30) -> [Color] {
        let start = -Double(count / 2) * angle
        return (0..<count).map { i in
            adjustHue(by: start + Double(i) * angle)
        }
    }
}

// MARK: - Gradients

extension Color {
    /**
     Creates a gradient from this color to another.

     - Parameters:
       - end: End color
       - steps: Number of colors in the gradient
       - perceptual: Use LAB space for more natural gradients (default true)
     - Returns: Array of colors forming the gradient

     ```swift
     let gradient = Color.red.gradient(to: .blue, steps: 5)
     ```
     */
    public func gradient(to end: Color, steps: Int, perceptual: Bool = true) -> [Color] {
        guard steps > 1 else { return [self] }

        return (0..<steps).map { i in
            let ratio = Double(i) / Double(steps - 1)
            if perceptual {
                return mixLAB(with: end, ratio: ratio)
            } else {
                return mix(with: end, ratio: ratio)
            }
        }
    }

    /**
     Creates a multi-stop gradient through multiple colors.

     - Parameters:
       - colors: Colors to pass through
       - stepsPerSegment: Steps between each color pair
       - perceptual: Use LAB space for more natural gradients
     - Returns: Array of colors forming the gradient

     ```swift
     let rainbow = Color.red.multiGradient(
         through: [.yellow, .green, .blue],
         stepsPerSegment: 10
     )
     ```
     */
    public func multiGradient(through colors: [Color], stepsPerSegment: Int = 10, perceptual: Bool = true) -> [Color] {
        let allColors = [self] + colors
        var result: [Color] = []

        for i in 0..<(allColors.count - 1) {
            let segment = allColors[i].gradient(to: allColors[i + 1], steps: stepsPerSegment, perceptual: perceptual)
            // Don't duplicate the end color (it becomes the start of next segment)
            if i < allColors.count - 2 {
                result.append(contentsOf: segment.dropLast())
            } else {
                result.append(contentsOf: segment)
            }
        }

        return result
    }
}

// MARK: - Tint & Shade Scales

extension Color {
    /**
     Creates a series of tints (lighter versions mixed with white).

     - Parameter count: Number of tints to generate
     - Returns: Array from this color to white

     ```swift
     let tints = Color.blue.tints(count: 5)
     ```
     */
    public func tints(count: Int) -> [Color] {
        gradient(to: .white, steps: count, perceptual: false)
    }

    /**
     Creates a series of shades (darker versions mixed with black).

     - Parameter count: Number of shades to generate
     - Returns: Array from this color to black

     ```swift
     let shades = Color.blue.shades(count: 5)
     ```
     */
    public func shades(count: Int) -> [Color] {
        gradient(to: .black, steps: count, perceptual: false)
    }

    /**
     Creates a full tonal scale from black through the color to white.

     - Parameter count: Total number of colors (should be odd for symmetry)
     - Returns: Array from black through color to white

     ```swift
     let scale = Color.blue.tonalScale(count: 9)
     ```
     */
    public func tonalScale(count: Int) -> [Color] {
        let half = count / 2
        let shadeColors = Color.black.gradient(to: self, steps: half + 1, perceptual: false)
        let tintColors = gradient(to: .white, steps: count - half, perceptual: false)
        return Array(shadeColors.dropLast()) + tintColors
    }
}

// MARK: - Random Colors

extension Color {
    /**
     Generates a random color.

     - Parameter alpha: Optional fixed alpha value
     - Returns: Random color
     */
    public static func random(alpha: Double = 1.0) -> Color {
        Color(
            r: Double.random(in: 0...1),
            g: Double.random(in: 0...1),
            b: Double.random(in: 0...1),
            a: alpha
        )
    }

    /**
     Generates a random color with a specific hue.

     - Parameters:
       - hue: Hue angle in degrees (0-360)
       - saturation: Saturation range (default 0.5-1.0)
       - lightness: Lightness range (default 0.4-0.6)
     - Returns: Random color with the given hue
     */
    public static func randomWithHue(
        _ hue: Double,
        saturation: ClosedRange<Double> = 0.5...1.0,
        lightness: ClosedRange<Double> = 0.4...0.6
    ) -> Color {
        Color(
            h: hue,
            s: Double.random(in: saturation),
            l: Double.random(in: lightness)
        )
    }

    /**
     Generates a palette of visually distinct random colors.

     Uses golden ratio to space hues evenly.

     - Parameters:
       - count: Number of colors to generate
       - saturation: Fixed saturation (default 0.7)
       - lightness: Fixed lightness (default 0.5)
     - Returns: Array of distinct colors
     */
    public static func distinctPalette(count: Int, saturation: Double = 0.7, lightness: Double = 0.5) -> [Color] {
        let goldenRatio = 0.618033988749895
        var hue = Double.random(in: 0...1)

        return (0..<count).map { _ in
            hue = (hue + goldenRatio).truncatingRemainder(dividingBy: 1)
            return Color(h: hue * 360, s: saturation, l: lightness)
        }
    }
}
