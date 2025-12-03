/**
 A color represented in RGB color space.

 All component values are stored as `Double` in the range 0.0 to 1.0.
 Values outside this range are clamped during initialization.

 ```swift
 let red = Color(r: 1, g: 0, b: 0)
 let blue = Color(r: 0, g: 0, b: 1)
 let purple = red.mix(with: blue)
 ```
 */
public struct Color: Sendable, Hashable, Codable {
    /// Red component (0.0 to 1.0)
    public let red: Double

    /// Green component (0.0 to 1.0)
    public let green: Double

    /// Blue component (0.0 to 1.0)
    public let blue: Double

    /// Alpha component (0.0 to 1.0)
    public let alpha: Double

    /**
     Creates a color from RGB components.

     - Parameters:
       - r: Red component (0.0 to 1.0)
       - g: Green component (0.0 to 1.0)
       - b: Blue component (0.0 to 1.0)
       - a: Alpha component (0.0 to 1.0), defaults to 1.0
     */
    public init(r: Double, g: Double, b: Double, a: Double = 1.0) {
        self.red = Self.clamp(r)
        self.green = Self.clamp(g)
        self.blue = Self.clamp(b)
        self.alpha = Self.clamp(a)
    }

    /**
     Creates a color from 8-bit RGB values.

     - Parameters:
       - r: Red component (0 to 255)
       - g: Green component (0 to 255)
       - b: Blue component (0 to 255)
       - a: Alpha component (0 to 255), defaults to 255
     */
    public init(r: Int, g: Int, b: Int, a: Int = 255) {
        self.init(
            r: Double(r) / 255.0,
            g: Double(g) / 255.0,
            b: Double(b) / 255.0,
            a: Double(a) / 255.0
        )
    }

    /// Clamps a value to the range 0.0 to 1.0.
    @inline(__always)
    private static func clamp(_ value: Double) -> Double {
        min(max(value, 0.0), 1.0)
    }

    /// Returns a new color with clamped components.
    internal func clamped() -> Color {
        Color(r: red, g: green, b: blue, a: alpha)
    }
}

// MARK: - Common Colors

extension Color {
    /// Pure black (#000000)
    public static let black = Color(r: 0.0, g: 0.0, b: 0.0)

    /// Pure white (#FFFFFF)
    public static let white = Color(r: 1.0, g: 1.0, b: 1.0)

    /// Pure red (#FF0000)
    public static let red = Color(r: 1.0, g: 0.0, b: 0.0)

    /// Pure green (#00FF00)
    public static let green = Color(r: 0.0, g: 1.0, b: 0.0)

    /// Pure blue (#0000FF)
    public static let blue = Color(r: 0.0, g: 0.0, b: 1.0)

    /// Pure yellow (#FFFF00)
    public static let yellow = Color(r: 1.0, g: 1.0, b: 0.0)

    /// Pure cyan (#00FFFF)
    public static let cyan = Color(r: 0.0, g: 1.0, b: 1.0)

    /// Pure magenta (#FF00FF)
    public static let magenta = Color(r: 1.0, g: 0.0, b: 1.0)

    /// Transparent (alpha = 0)
    public static let clear = Color(r: 0.0, g: 0.0, b: 0.0, a: 0.0)

    /// 50% gray (#808080)
    public static let gray = Color(r: 0.5, g: 0.5, b: 0.5)
}

// MARK: - 8-bit Components

extension Color {
    /// Red component as 8-bit integer (0-255)
    public var red8: Int { Int((red * 255).rounded()) }

    /// Green component as 8-bit integer (0-255)
    public var green8: Int { Int((green * 255).rounded()) }

    /// Blue component as 8-bit integer (0-255)
    public var blue8: Int { Int((blue * 255).rounded()) }

    /// Alpha component as 8-bit integer (0-255)
    public var alpha8: Int { Int((alpha * 255).rounded()) }
}

// MARK: - With Alpha

extension Color {
    /**
     Returns a new color with the specified alpha value.

     - Parameter alpha: New alpha value (0.0 to 1.0)
     - Returns: A new color with the given alpha
     */
    public func withAlpha(_ alpha: Double) -> Color {
        Color(r: red, g: green, b: blue, a: alpha)
    }
}

// MARK: - CustomStringConvertible

extension Color: CustomStringConvertible {
    public var description: String {
        if alpha < 1.0 {
            return "Color(r: \(red), g: \(green), b: \(blue), a: \(alpha))"
        }
        return "Color(r: \(red), g: \(green), b: \(blue))"
    }
}
