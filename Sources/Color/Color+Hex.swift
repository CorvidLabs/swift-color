import Foundation

// MARK: - Hex String Parsing

extension Color {
    /**
     Creates a color from a hex string.

     Supports formats:
     - `#RGB` - 3 character shorthand
     - `#RGBA` - 4 character shorthand with alpha
     - `#RRGGBB` - 6 character standard
     - `#RRGGBBAA` - 8 character with alpha
     - Same formats without `#` prefix
     - `0x` prefix also supported

     ```swift
     let red = Color(hex: "#FF0000")
     let blue = Color(hex: "0000FF")
     let green = Color(hex: "#0F0")  // shorthand
     let transparent = Color(hex: "#FF000080")  // 50% alpha
     ```

     - Parameter hex: Hex color string
     - Returns: Color if parsing succeeds, nil otherwise
     */
    public init?(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)

        // Remove common prefixes
        if hexString.hasPrefix("#") {
            hexString.removeFirst()
        } else if hexString.hasPrefix("0x") || hexString.hasPrefix("0X") {
            hexString.removeFirst(2)
        }

        // Expand shorthand notation
        switch hexString.count {
        case 3: // RGB -> RRGGBB
            hexString = hexString.map { "\($0)\($0)" }.joined()
        case 4: // RGBA -> RRGGBBAA
            hexString = hexString.map { "\($0)\($0)" }.joined()
        case 6, 8:
            break // Valid lengths
        default:
            return nil
        }

        guard let value = UInt64(hexString, radix: 16) else {
            return nil
        }

        if hexString.count == 8 {
            // RRGGBBAA
            let r = Double((value >> 24) & 0xFF) / 255.0
            let g = Double((value >> 16) & 0xFF) / 255.0
            let b = Double((value >> 8) & 0xFF) / 255.0
            let a = Double(value & 0xFF) / 255.0
            self.init(r: r, g: g, b: b, a: a)
        } else {
            // RRGGBB
            let r = Double((value >> 16) & 0xFF) / 255.0
            let g = Double((value >> 8) & 0xFF) / 255.0
            let b = Double(value & 0xFF) / 255.0
            self.init(r: r, g: g, b: b)
        }
    }

    /**
     The color as a hex string with `#` prefix.

     Returns 6 characters for opaque colors, 8 for colors with alpha.

     ```swift
     Color.red.hex  // "#FF0000"
     Color.red.withAlpha(0.5).hex  // "#FF000080"
     ```
     */
    public var hex: String {
        if alpha < 1.0 {
            return String(format: "#%02X%02X%02X%02X", red8, green8, blue8, alpha8)
        }
        return String(format: "#%02X%02X%02X", red8, green8, blue8)
    }

    /// The color as a hex string without `#` prefix.
    public var hexValue: String {
        String(hex.dropFirst())
    }
}

// MARK: - CSS rgba() Format

extension Color {
    /**
     The color as a CSS `rgb()` or `rgba()` string.

     ```swift
     Color.red.css  // "rgb(255, 0, 0)"
     Color.red.withAlpha(0.5).css  // "rgba(255, 0, 0, 0.5)"
     ```
     */
    public var css: String {
        if alpha < 1.0 {
            return "rgba(\(red8), \(green8), \(blue8), \(String(format: "%.2f", alpha)))"
        }
        return "rgb(\(red8), \(green8), \(blue8))"
    }

    /**
     Creates a color from a CSS `rgb()` or `rgba()` string.

     - Parameter css: CSS color string like `rgb(255, 0, 0)` or `rgba(255, 0, 0, 0.5)`
     - Returns: Color if parsing succeeds, nil otherwise
     */
    public init?(css: String) {
        let trimmed = css.trimmingCharacters(in: .whitespaces)

        // Match rgba(r, g, b, a) or rgb(r, g, b)
        let pattern = #"rgba?\s*\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*(?:,\s*([\d.]+))?\s*\)"#

        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive),
              let match = regex.firstMatch(in: trimmed, range: NSRange(trimmed.startIndex..., in: trimmed)) else {
            return nil
        }

        func extractInt(_ index: Int) -> Int? {
            guard let range = Range(match.range(at: index), in: trimmed) else { return nil }
            return Int(trimmed[range])
        }

        func extractDouble(_ index: Int) -> Double? {
            guard let range = Range(match.range(at: index), in: trimmed) else { return nil }
            return Double(trimmed[range])
        }

        guard let r = extractInt(1),
              let g = extractInt(2),
              let b = extractInt(3) else {
            return nil
        }

        let a = extractDouble(4) ?? 1.0

        self.init(r: r, g: g, b: b, a: Int(a * 255))
    }
}
