import Foundation

// MARK: - CIE LAB Color Space

/**
 CIE L*a*b* color representation.

 LAB is a perceptually uniform color space where equal distances
 represent roughly equal perceived color differences.
 */
public struct LAB: Sendable, Hashable {
    /// Lightness (0 to 100)
    public let lightness: Double

    /// Green-red component (-128 to 127)
    public let a: Double

    /// Blue-yellow component (-128 to 127)
    public let b: Double

    /// Creates a LAB value.
    public init(l: Double, a: Double, b: Double) {
        self.lightness = min(max(l, 0), 100)
        self.a = a
        self.b = b
    }
}

/// CIE LCH color representation (cylindrical form of LAB).
public struct LCH: Sendable, Hashable {
    /// Lightness (0 to 100)
    public let lightness: Double

    /// Chroma (saturation, 0 to ~132)
    public let chroma: Double

    /// Hue angle in degrees (0 to 360)
    public let hue: Double

    /// Creates an LCH value.
    public init(l: Double, c: Double, h: Double) {
        self.lightness = min(max(l, 0), 100)
        self.chroma = max(c, 0)
        self.hue = h.truncatingRemainder(dividingBy: 360)
    }
}

// MARK: - XYZ Color Space (Intermediate)

/// CIE XYZ color representation (intermediate for LAB conversion).
internal struct XYZ: Sendable {
    let x: Double
    let y: Double
    let z: Double
}

// MARK: - LAB Conversion

extension Color {
    /// D65 standard illuminant reference values
    private static let d65: (x: Double, y: Double, z: Double) = (95.047, 100.0, 108.883)

    /// Converts RGB to XYZ color space.
    private var xyz: XYZ {
        func linearize(_ channel: Double) -> Double {
            if channel > 0.04045 {
                return pow((channel + 0.055) / 1.055, 2.4)
            } else {
                return channel / 12.92
            }
        }

        let r = linearize(red) * 100
        let g = linearize(green) * 100
        let b = linearize(blue) * 100

        // sRGB to XYZ matrix
        return XYZ(
            x: r * 0.4124564 + g * 0.3575761 + b * 0.1804375,
            y: r * 0.2126729 + g * 0.7151522 + b * 0.0721750,
            z: r * 0.0193339 + g * 0.1191920 + b * 0.9503041
        )
    }

    /// Creates a color from XYZ values.
    private init(xyz: XYZ, alpha: Double = 1.0) {
        func delinearize(_ value: Double) -> Double {
            if value > 0.0031308 {
                return 1.055 * pow(value, 1.0 / 2.4) - 0.055
            } else {
                return 12.92 * value
            }
        }

        let x = xyz.x / 100
        let y = xyz.y / 100
        let z = xyz.z / 100

        // XYZ to sRGB matrix
        let r = delinearize(x * 3.2404542 + y * -1.5371385 + z * -0.4985314)
        let g = delinearize(x * -0.9692660 + y * 1.8760108 + z * 0.0415560)
        let b = delinearize(x * 0.0556434 + y * -0.2040259 + z * 1.0572252)

        self.init(r: r, g: g, b: b, a: alpha)
    }

    /**
     The color in CIE L*a*b* representation.

     ```swift
     let lab = Color.red.lab
     print(lab)  // LAB(l: 53.2, a: 80.1, b: 67.2)
     ```
     */
    public var lab: LAB {
        let xyz = self.xyz

        func f(_ t: Double) -> Double {
            let delta: Double = 6.0 / 29.0
            if t > pow(delta, 3) {
                return pow(t, 1.0 / 3.0)
            } else {
                return t / (3 * pow(delta, 2)) + 4.0 / 29.0
            }
        }

        let fx = f(xyz.x / Self.d65.x)
        let fy = f(xyz.y / Self.d65.y)
        let fz = f(xyz.z / Self.d65.z)

        return LAB(
            l: 116 * fy - 16,
            a: 500 * (fx - fy),
            b: 200 * (fy - fz)
        )
    }

    /**
     Creates a color from CIE L*a*b* values.

     - Parameters:
       - l: Lightness (0 to 100)
       - a: Green-red component (-128 to 127)
       - b: Blue-yellow component (-128 to 127)
       - alpha: Alpha component (0.0 to 1.0)
     */
    public init(l: Double, a: Double, b: Double, alpha: Double = 1.0) {
        let lab = LAB(l: l, a: a, b: b)
        self.init(lab: lab, alpha: alpha)
    }

    /// Creates a color from a LAB value.
    public init(lab: LAB, alpha: Double = 1.0) {
        func fInverse(_ t: Double) -> Double {
            let delta: Double = 6.0 / 29.0
            if t > delta {
                return pow(t, 3)
            } else {
                return 3 * pow(delta, 2) * (t - 4.0 / 29.0)
            }
        }

        let fy = (lab.lightness + 16) / 116
        let fx = lab.a / 500 + fy
        let fz = fy - lab.b / 200

        let xyz = XYZ(
            x: Self.d65.x * fInverse(fx),
            y: Self.d65.y * fInverse(fy),
            z: Self.d65.z * fInverse(fz)
        )

        self.init(xyz: xyz, alpha: alpha)
    }
}

// MARK: - LCH Conversion

extension Color {
    /**
     The color in CIE LCH representation (cylindrical LAB).

     LCH is useful for color manipulation because hue is directly accessible.

     ```swift
     let lch = Color.red.lch
     print(lch)  // LCH(l: 53.2, c: 104.6, h: 40.0)
     ```
     */
    public var lch: LCH {
        let lab = self.lab
        let c = sqrt(lab.a * lab.a + lab.b * lab.b)
        var h = atan2(lab.b, lab.a) * 180 / .pi
        if h < 0 { h += 360 }

        return LCH(l: lab.lightness, c: c, h: h)
    }

    /**
     Creates a color from CIE LCH values.

     - Parameters:
       - l: Lightness (0 to 100)
       - c: Chroma (saturation)
       - h: Hue angle in degrees (0 to 360)
       - alpha: Alpha component (0.0 to 1.0)
     */
    public init(l: Double, c: Double, h: Double, alpha: Double = 1.0) {
        let lch = LCH(l: l, c: c, h: h)
        self.init(lch: lch, alpha: alpha)
    }

    /// Creates a color from an LCH value.
    public init(lch: LCH, alpha: Double = 1.0) {
        let hRad = lch.hue * .pi / 180
        let lab = LAB(
            l: lch.lightness,
            a: lch.chroma * cos(hRad),
            b: lch.chroma * sin(hRad)
        )
        self.init(lab: lab, alpha: alpha)
    }
}

// MARK: - Perceptual Operations

extension Color {
    /**
     Returns the perceptual difference (Delta E) between two colors.

     Uses CIE76 formula. Values < 1 are imperceptible,
     1-2 are barely noticeable, > 100 are completely different.

     - Parameter other: Color to compare with
     - Returns: Delta E value
     */
    public func deltaE(from other: Color) -> Double {
        let lab1 = self.lab
        let lab2 = other.lab

        let dL = lab1.lightness - lab2.lightness
        let dA = lab1.a - lab2.a
        let dB = lab1.b - lab2.b

        return sqrt(dL * dL + dA * dA + dB * dB)
    }

    /**
     Mixes two colors in perceptually uniform LAB space.

     Produces more natural gradients than RGB mixing.

     - Parameters:
       - other: Color to mix with
       - ratio: Mix ratio (0.0 = this color, 1.0 = other color)
     - Returns: Mixed color
     */
    public func mixLAB(with other: Color, ratio: Double = 0.5) -> Color {
        let t = min(max(ratio, 0), 1)
        let lab1 = self.lab
        let lab2 = other.lab

        return Color(
            l: lab1.lightness + (lab2.lightness - lab1.lightness) * t,
            a: lab1.a + (lab2.a - lab1.a) * t,
            b: lab1.b + (lab2.b - lab1.b) * t,
            alpha: alpha + (other.alpha - alpha) * t
        )
    }
}
