import Foundation

// MARK: - WCAG Accessibility

/// WCAG conformance levels for contrast requirements.
public enum WCAGLevel: Sendable {
    /// WCAG AA - minimum contrast 4.5:1 for normal text, 3:1 for large text
    case aa

    /// WCAG AAA - enhanced contrast 7:1 for normal text, 4.5:1 for large text
    case aaa

    /// Minimum contrast ratio for normal text
    public var normalTextRatio: Double {
        switch self {
        case .aa: return 4.5
        case .aaa: return 7.0
        }
    }

    /// Minimum contrast ratio for large text (18pt+ or 14pt bold)
    public var largeTextRatio: Double {
        switch self {
        case .aa: return 3.0
        case .aaa: return 4.5
        }
    }
}

extension Color {
    /**
     Relative luminance according to WCAG 2.1.

     Value ranges from 0.0 (black) to 1.0 (white).

     ```swift
     Color.white.luminance  // 1.0
     Color.black.luminance  // 0.0
     Color.red.luminance    // ~0.2126
     ```
     */
    public var luminance: Double {
        func adjust(_ channel: Double) -> Double {
            if channel <= 0.03928 {
                return channel / 12.92
            } else {
                return pow((channel + 0.055) / 1.055, 2.4)
            }
        }

        return 0.2126 * adjust(red) + 0.7152 * adjust(green) + 0.0722 * adjust(blue)
    }

    /**
     Calculates the contrast ratio with another color.

     The contrast ratio ranges from 1:1 (no contrast) to 21:1 (black/white).
     WCAG requires at least 4.5:1 for normal text (AA) or 7:1 (AAA).

     - Parameter other: Color to compare against
     - Returns: Contrast ratio (1.0 to 21.0)

     ```swift
     Color.black.contrastRatio(with: .white)  // 21.0
     Color.red.contrastRatio(with: .white)    // ~4.0
     ```
     */
    public func contrastRatio(with other: Color) -> Double {
        let l1 = luminance
        let l2 = other.luminance
        let lighter = max(l1, l2)
        let darker = min(l1, l2)
        return (lighter + 0.05) / (darker + 0.05)
    }

    /**
     Checks if the color combination meets WCAG accessibility requirements.

     - Parameters:
       - background: The background color
       - level: WCAG conformance level (.aa or .aaa)
       - largeText: Whether text is large (18pt+ or 14pt bold). Default is false.
     - Returns: True if contrast meets requirements

     ```swift
     Color.black.isAccessible(on: .white, level: .aa)  // true
     Color.red.isAccessible(on: .white, level: .aa)    // false
     ```
     */
    public func isAccessible(on background: Color, level: WCAGLevel = .aa, largeText: Bool = false) -> Bool {
        let ratio = contrastRatio(with: background)
        let required = largeText ? level.largeTextRatio : level.normalTextRatio
        return ratio >= required
    }

    /**
     Returns black or white, whichever provides better contrast against this color.

     Useful for automatically selecting text color based on background.

     ```swift
     Color.red.textColor(on: .red)      // .white
     Color.yellow.textColor(on: .yellow) // .black
     ```
     */
    public func textColor(on background: Color = .white) -> Color {
        background.luminance > 0.179 ? .black : .white
    }

    /**
     Suggests a text color (black or white) that works on this background.

     ```swift
     let textColor = backgroundColor.contrastingTextColor
     ```
     */
    public var contrastingTextColor: Color {
        textColor(on: self)
    }

    /**
     Finds the closest color that meets accessibility requirements.

     Adjusts lightness until the contrast ratio is met.

     - Parameters:
       - background: Background color
       - level: WCAG conformance level
     - Returns: Adjusted color that meets requirements, or nil if impossible
     */
    public func adjustedForAccessibility(on background: Color, level: WCAGLevel = .aa) -> Color? {
        let requiredRatio = level.normalTextRatio

        // Already accessible
        if contrastRatio(with: background) >= requiredRatio {
            return self
        }

        let h = hsl
        let bgLuminance = background.luminance

        // Try adjusting lightness in both directions
        for delta in stride(from: 0.01, through: 1.0, by: 0.01) {
            // Try darker
            let darker = Color(h: h.hue, s: h.saturation, l: max(h.lightness - delta, 0), a: alpha)
            if darker.contrastRatio(with: background) >= requiredRatio {
                return darker
            }

            // Try lighter
            let lighter = Color(h: h.hue, s: h.saturation, l: min(h.lightness + delta, 1), a: alpha)
            if lighter.contrastRatio(with: background) >= requiredRatio {
                return lighter
            }
        }

        // If we can't find a good match, return black or white
        return bgLuminance > 0.5 ? .black : .white
    }
}

// MARK: - Color Blindness Simulation

extension Color {
    /// Simulates how this color appears to someone with protanopia (red-blind).
    public var simulatedProtanopia: Color {
        Color(
            r: 0.567 * red + 0.433 * green,
            g: 0.558 * red + 0.442 * green,
            b: 0.242 * green + 0.758 * blue,
            a: alpha
        )
    }

    /// Simulates how this color appears to someone with deuteranopia (green-blind).
    public var simulatedDeuteranopia: Color {
        Color(
            r: 0.625 * red + 0.375 * green,
            g: 0.7 * red + 0.3 * green,
            b: 0.3 * green + 0.7 * blue,
            a: alpha
        )
    }

    /// Simulates how this color appears to someone with tritanopia (blue-blind).
    public var simulatedTritanopia: Color {
        Color(
            r: 0.95 * red + 0.05 * green,
            g: 0.433 * green + 0.567 * blue,
            b: 0.475 * green + 0.525 * blue,
            a: alpha
        )
    }
}
