import Foundation

// MARK: - HSV Color Space

/**
 HSV (Hue, Saturation, Value) representation.
 Also known as HSB (Hue, Saturation, Brightness).
 */
public struct HSV: Sendable, Hashable {
    /// Hue angle in degrees (0-360)
    public let hue: Double

    /// Saturation (0.0 to 1.0)
    public let saturation: Double

    /// Value/Brightness (0.0 to 1.0)
    public let value: Double

    /// Creates an HSV value.
    public init(h: Double, s: Double, v: Double) {
        self.hue = h.truncatingRemainder(dividingBy: 360)
        self.saturation = min(max(s, 0), 1)
        self.value = min(max(v, 0), 1)
    }
}

extension Color {
    /**
     The color in HSV representation.

     ```swift
     let red = Color.red
     print(red.hsv)  // HSV(h: 0, s: 1.0, v: 1.0)
     ```
     */
    public var hsv: HSV {
        let maxC = max(red, green, blue)
        let minC = min(red, green, blue)
        let delta = maxC - minC

        // Value
        let v = maxC

        // Achromatic
        guard delta > 0 else {
            return HSV(h: 0, s: 0, v: v)
        }

        // Saturation
        let s = delta / maxC

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

        return HSV(h: h, s: s, v: v)
    }

    /**
     Creates a color from HSV values.

     - Parameters:
       - h: Hue angle in degrees (0-360)
       - s: Saturation (0.0 to 1.0)
       - v: Value/Brightness (0.0 to 1.0)
       - a: Alpha (0.0 to 1.0), defaults to 1.0
     */
    public init(h: Double, s: Double, v: Double, a: Double = 1.0) {
        let hsv = HSV(h: h, s: s, v: v)
        self.init(hsv: hsv, alpha: a)
    }

    /**
     Creates a color from an HSV value.

     - Parameters:
       - hsv: HSV color value
       - alpha: Alpha component, defaults to 1.0
     */
    public init(hsv: HSV, alpha: Double = 1.0) {
        let h = hsv.hue
        let s = hsv.saturation
        let v = hsv.value

        // Achromatic
        guard s > 0 else {
            self.init(r: v, g: v, b: v, a: alpha)
            return
        }

        let c = v * s
        let x = c * (1 - abs((h / 60).truncatingRemainder(dividingBy: 2) - 1))
        let m = v - c

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
