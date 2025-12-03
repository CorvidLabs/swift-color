import Foundation

// MARK: - Color Manipulation

extension Color {
    /**
     Returns a lighter version of the color.

     - Parameter amount: Amount to lighten (0.0 to 1.0). Default is 0.1 (10%).
     - Returns: Lightened color

     ```swift
     let light = Color.red.lighten(by: 0.2)
     ```
     */
    public func lighten(by amount: Double = 0.1) -> Color {
        let h = hsl
        let newLightness = min(h.lightness + amount, 1.0)
        return Color(h: h.hue, s: h.saturation, l: newLightness, a: alpha)
    }

    /**
     Returns a darker version of the color.

     - Parameter amount: Amount to darken (0.0 to 1.0). Default is 0.1 (10%).
     - Returns: Darkened color

     ```swift
     let dark = Color.red.darken(by: 0.2)
     ```
     */
    public func darken(by amount: Double = 0.1) -> Color {
        let h = hsl
        let newLightness = max(h.lightness - amount, 0.0)
        return Color(h: h.hue, s: h.saturation, l: newLightness, a: alpha)
    }

    /**
     Returns a more saturated version of the color.

     - Parameter amount: Amount to increase saturation (0.0 to 1.0). Default is 0.1 (10%).
     - Returns: More saturated color

     ```swift
     let vivid = Color.gray.saturate(by: 0.5)
     ```
     */
    public func saturate(by amount: Double = 0.1) -> Color {
        let h = hsl
        let newSaturation = min(h.saturation + amount, 1.0)
        return Color(h: h.hue, s: newSaturation, l: h.lightness, a: alpha)
    }

    /**
     Returns a less saturated version of the color.

     - Parameter amount: Amount to decrease saturation (0.0 to 1.0). Default is 0.1 (10%).
     - Returns: Less saturated color

     ```swift
     let muted = Color.red.desaturate(by: 0.3)
     ```
     */
    public func desaturate(by amount: Double = 0.1) -> Color {
        let h = hsl
        let newSaturation = max(h.saturation - amount, 0.0)
        return Color(h: h.hue, s: newSaturation, l: h.lightness, a: alpha)
    }

    /**
     Returns a grayscale version of the color.

     Uses the luminance formula for perceptually accurate conversion.

     ```swift
     let gray = Color.red.grayscale
     ```
     */
    public var grayscale: Color {
        let gray = 0.2126 * red + 0.7152 * green + 0.0722 * blue
        return Color(r: gray, g: gray, b: gray, a: alpha)
    }

    /**
     Returns the inverted (negative) color.

     ```swift
     let inverted = Color.red.inverted  // cyan
     ```
     */
    public var inverted: Color {
        Color(r: 1 - red, g: 1 - green, b: 1 - blue, a: alpha)
    }

    /**
     Returns the complementary color (opposite on the color wheel).

     ```swift
     let complement = Color.red.complement  // cyan
     ```
     */
    public var complement: Color {
        adjustHue(by: 180)
    }

    /**
     Returns the color with hue rotated by the given degrees.

     - Parameter degrees: Degrees to rotate (can be negative)
     - Returns: Color with adjusted hue

     ```swift
     let rotated = Color.red.adjustHue(by: 120)  // green
     ```
     */
    public func adjustHue(by degrees: Double) -> Color {
        let h = hsl
        var newHue = h.hue + degrees
        while newHue < 0 { newHue += 360 }
        while newHue >= 360 { newHue -= 360 }
        return Color(h: newHue, s: h.saturation, l: h.lightness, a: alpha)
    }

    /**
     Mixes this color with another color.

     - Parameters:
       - other: The color to mix with
       - ratio: Mix ratio (0.0 = this color, 1.0 = other color). Default is 0.5.
     - Returns: Blended color

     ```swift
     let purple = Color.red.mix(with: .blue)  // 50% red, 50% blue
     let pinkish = Color.red.mix(with: .white, ratio: 0.3)
     ```
     */
    public func mix(with other: Color, ratio: Double = 0.5) -> Color {
        let t = min(max(ratio, 0), 1)
        return Color(
            r: red + (other.red - red) * t,
            g: green + (other.green - green) * t,
            b: blue + (other.blue - blue) * t,
            a: alpha + (other.alpha - alpha) * t
        )
    }

    /**
     Returns a tinted version (mixed with white).

     - Parameter amount: Amount of white to add (0.0 to 1.0). Default is 0.5.
     - Returns: Tinted color
     */
    public func tint(by amount: Double = 0.5) -> Color {
        mix(with: .white, ratio: amount)
    }

    /**
     Returns a shaded version (mixed with black).

     - Parameter amount: Amount of black to add (0.0 to 1.0). Default is 0.5.
     - Returns: Shaded color
     */
    public func shade(by amount: Double = 0.5) -> Color {
        mix(with: .black, ratio: amount)
    }
}

// MARK: - Blend Modes

extension Color {
    /**
     Multiplies the color components.

     - Parameter other: Color to multiply with
     - Returns: Multiplied color (typically darker)
     */
    public func multiply(with other: Color) -> Color {
        Color(
            r: red * other.red,
            g: green * other.green,
            b: blue * other.blue,
            a: alpha
        )
    }

    /**
     Screen blend mode (inverse multiply).

     - Parameter other: Color to screen with
     - Returns: Screened color (typically lighter)
     */
    public func screen(with other: Color) -> Color {
        Color(
            r: 1 - (1 - red) * (1 - other.red),
            g: 1 - (1 - green) * (1 - other.green),
            b: 1 - (1 - blue) * (1 - other.blue),
            a: alpha
        )
    }

    /**
     Overlay blend mode (combination of multiply and screen).

     - Parameter other: Color to overlay with
     - Returns: Overlaid color
     */
    public func overlay(with other: Color) -> Color {
        func overlayChannel(_ base: Double, _ blend: Double) -> Double {
            if base < 0.5 {
                return 2 * base * blend
            } else {
                return 1 - 2 * (1 - base) * (1 - blend)
            }
        }

        return Color(
            r: overlayChannel(red, other.red),
            g: overlayChannel(green, other.green),
            b: overlayChannel(blue, other.blue),
            a: alpha
        )
    }
}
