import Foundation

// MARK: - HSL Color Space

/// HSL (Hue, Saturation, Lightness) representation.
public struct HSL: Sendable, Hashable {
    /// Hue angle in degrees (0-360)
    public let hue: Double

    /// Saturation (0.0 to 1.0)
    public let saturation: Double

    /// Lightness (0.0 to 1.0)
    public let lightness: Double

    /// Creates an HSL value.
    public init(h: Double, s: Double, l: Double) {
        self.hue = h.truncatingRemainder(dividingBy: 360)
        self.saturation = min(max(s, 0), 1)
        self.lightness = min(max(l, 0), 1)
    }
}

extension Color {
    /**
     The color in HSL representation.

     ```swift
     let red = Color.red
     print(red.hsl)  // HSL(h: 0, s: 1.0, l: 0.5)
     ```
     */
    public var hsl: HSL {
        let maxC = max(red, green, blue)
        let minC = min(red, green, blue)
        let delta = maxC - minC

        // Lightness
        let l = (maxC + minC) / 2.0

        // Achromatic
        guard delta > 0 else {
            return HSL(h: 0, s: 0, l: l)
        }

        // Saturation
        let s = delta / (1 - abs(2 * l - 1))

        // Hue
        var h: Double
        switch maxC {
        case red:
            h = 60 * (((green - blue) / delta).truncatingRemainder(dividingBy: 6))
        case green:
            h = 60 * ((blue - red) / delta + 2)
        default:
            h = 60 * ((red - green) / delta + 4)
        }

        if h < 0 {
            h += 360
        }

        return HSL(h: h, s: s, l: l)
    }

    /**
     Creates a color from HSL values.

     - Parameters:
       - h: Hue angle in degrees (0-360)
       - s: Saturation (0.0 to 1.0)
       - l: Lightness (0.0 to 1.0)
       - a: Alpha (0.0 to 1.0), defaults to 1.0
     */
    public init(h: Double, s: Double, l: Double, a: Double = 1.0) {
        let hsl = HSL(h: h, s: s, l: l)
        self.init(hsl: hsl, alpha: a)
    }

    /**
     Creates a color from an HSL value.

     - Parameters:
       - hsl: HSL color value
       - alpha: Alpha component, defaults to 1.0
     */
    public init(hsl: HSL, alpha: Double = 1.0) {
        let h = hsl.hue
        let s = hsl.saturation
        let l = hsl.lightness

        // Achromatic
        guard s > 0 else {
            self.init(r: l, g: l, b: l, a: alpha)
            return
        }

        let c = (1 - abs(2 * l - 1)) * s
        let x = c * (1 - abs((h / 60).truncatingRemainder(dividingBy: 2) - 1))
        let m = l - c / 2

        let (r1, g1, b1): (Double, Double, Double)

        switch h {
        case 0..<60:
            (r1, g1, b1) = (c, x, 0)
        case 60..<120:
            (r1, g1, b1) = (x, c, 0)
        case 120..<180:
            (r1, g1, b1) = (0, c, x)
        case 180..<240:
            (r1, g1, b1) = (0, x, c)
        case 240..<300:
            (r1, g1, b1) = (x, 0, c)
        default:
            (r1, g1, b1) = (c, 0, x)
        }

        self.init(r: r1 + m, g: g1 + m, b: b1 + m, a: alpha)
    }
}

// MARK: - CSS hsl() Format

extension Color {
    /**
     The color as a CSS `hsl()` or `hsla()` string.

     ```swift
     Color.red.cssHSL  // "hsl(0, 100%, 50%)"
     ```
     */
    public var cssHSL: String {
        let h = hsl
        if alpha < 1.0 {
            return String(format: "hsla(%.0f, %.0f%%, %.0f%%, %.2f)",
                          h.hue, h.saturation * 100, h.lightness * 100, alpha)
        }
        return String(format: "hsl(%.0f, %.0f%%, %.0f%%)",
                      h.hue, h.saturation * 100, h.lightness * 100)
    }
}
