/**
 Standard CSS named colors.

 The standard CSS named colors (139 enum cases). `cyan` and `magenta`
 are provided as static aliases for `aqua` and `fuchsia` respectively,
 since they share identical hex values.

 ```swift
 let color = Color.named(.coral)
 let hex = NamedColor.steelBlue.hex  // "#4682B4"
 ```
 */
public enum NamedColor: String, CaseIterable, Sendable {
    // Reds
    case indianRed = "CD5C5C"
    case lightCoral = "F08080"
    case salmon = "FA8072"
    case darkSalmon = "E9967A"
    case lightSalmon = "FFA07A"
    case crimson = "DC143C"
    case red = "FF0000"
    case fireBrick = "B22222"
    case darkRed = "8B0000"

    // Pinks
    case pink = "FFC0CB"
    case lightPink = "FFB6C1"
    case hotPink = "FF69B4"
    case deepPink = "FF1493"
    case mediumVioletRed = "C71585"
    case paleVioletRed = "DB7093"

    // Oranges
    case coral = "FF7F50"
    case tomato = "FF6347"
    case orangeRed = "FF4500"
    case darkOrange = "FF8C00"
    case orange = "FFA500"

    // Yellows
    case gold = "FFD700"
    case yellow = "FFFF00"
    case lightYellow = "FFFFE0"
    case lemonChiffon = "FFFACD"
    case lightGoldenrodYellow = "FAFAD2"
    case papayaWhip = "FFEFD5"
    case moccasin = "FFE4B5"
    case peachPuff = "FFDAB9"
    case paleGoldenrod = "EEE8AA"
    case khaki = "F0E68C"
    case darkKhaki = "BDB76B"

    // Purples
    case lavender = "E6E6FA"
    case thistle = "D8BFD8"
    case plum = "DDA0DD"
    case violet = "EE82EE"
    case orchid = "DA70D6"
    case fuchsia = "FF00FF"
    // magenta is same as fuchsia (alias)
    case mediumOrchid = "BA55D3"
    case mediumPurple = "9370DB"
    case rebeccaPurple = "663399"
    case blueViolet = "8A2BE2"
    case darkViolet = "9400D3"
    case darkOrchid = "9932CC"
    case darkMagenta = "8B008B"
    case purple = "800080"
    case indigo = "4B0082"
    case slateBlue = "6A5ACD"
    case darkSlateBlue = "483D8B"
    case mediumSlateBlue = "7B68EE"

    // Greens
    case greenYellow = "ADFF2F"
    case chartreuse = "7FFF00"
    case lawnGreen = "7CFC00"
    case lime = "00FF00"
    case limeGreen = "32CD32"
    case paleGreen = "98FB98"
    case lightGreen = "90EE90"
    case mediumSpringGreen = "00FA9A"
    case springGreen = "00FF7F"
    case mediumSeaGreen = "3CB371"
    case seaGreen = "2E8B57"
    case forestGreen = "228B22"
    case green = "008000"
    case darkGreen = "006400"
    case yellowGreen = "9ACD32"
    case oliveDrab = "6B8E23"
    case olive = "808000"
    case darkOliveGreen = "556B2F"
    case mediumAquamarine = "66CDAA"
    case darkSeaGreen = "8FBC8F"
    case lightSeaGreen = "20B2AA"
    case darkCyan = "008B8B"
    case teal = "008080"

    // Blues
    case aqua = "00FFFF"
    // cyan is same as aqua (alias)
    case lightCyan = "E0FFFF"
    case paleTurquoise = "AFEEEE"
    case aquamarine = "7FFFD4"
    case turquoise = "40E0D0"
    case mediumTurquoise = "48D1CC"
    case darkTurquoise = "00CED1"
    case cadetBlue = "5F9EA0"
    case steelBlue = "4682B4"
    case lightSteelBlue = "B0C4DE"
    case powderBlue = "B0E0E6"
    case lightBlue = "ADD8E6"
    case skyBlue = "87CEEB"
    case lightSkyBlue = "87CEFA"
    case deepSkyBlue = "00BFFF"
    case dodgerBlue = "1E90FF"
    case cornflowerBlue = "6495ED"
    case royalBlue = "4169E1"
    case blue = "0000FF"
    case mediumBlue = "0000CD"
    case darkBlue = "00008B"
    case navy = "000080"
    case midnightBlue = "191970"

    // Browns
    case cornsilk = "FFF8DC"
    case blanchedAlmond = "FFEBCD"
    case bisque = "FFE4C4"
    case navajoWhite = "FFDEAD"
    case wheat = "F5DEB3"
    case burlyWood = "DEB887"
    case tan = "D2B48C"
    case rosyBrown = "BC8F8F"
    case sandyBrown = "F4A460"
    case goldenrod = "DAA520"
    case darkGoldenrod = "B8860B"
    case peru = "CD853F"
    case chocolate = "D2691E"
    case saddleBrown = "8B4513"
    case sienna = "A0522D"
    case brown = "A52A2A"
    case maroon = "800000"

    // Whites
    case white = "FFFFFF"
    case snow = "FFFAFA"
    case honeyDew = "F0FFF0"
    case mintCream = "F5FFFA"
    case azure = "F0FFFF"
    case aliceBlue = "F0F8FF"
    case ghostWhite = "F8F8FF"
    case whiteSmoke = "F5F5F5"
    case seaShell = "FFF5EE"
    case beige = "F5F5DC"
    case oldLace = "FDF5E6"
    case floralWhite = "FFFAF0"
    case ivory = "FFFFF0"
    case antiqueWhite = "FAEBD7"
    case linen = "FAF0E6"
    case lavenderBlush = "FFF0F5"
    case mistyRose = "FFE4E1"

    // Grays
    case gainsboro = "DCDCDC"
    case lightGray = "D3D3D3"
    case silver = "C0C0C0"
    case darkGray = "A9A9A9"
    case gray = "808080"
    case dimGray = "696969"
    case lightSlateGray = "778899"
    case slateGray = "708090"
    case darkSlateGray = "2F4F4F"
    case black = "000000"

    /// The hex code for this color (without # prefix).
    public var hex: String { rawValue }

    /// The color value.
    public var color: Color {
        Color(hex: rawValue)!
    }

    /// Alias: magenta is the same as fuchsia
    public static var magenta: NamedColor { .fuchsia }

    /// Alias: cyan is the same as aqua
    public static var cyan: NamedColor { .aqua }
}

// MARK: - Color Extension

extension Color {
    /**
     Creates a color from a named CSS color.

     ```swift
     let coral = Color.named(.coral)
     let navy = Color.named(.navy)
     ```
     */
    public static func named(_ name: NamedColor) -> Color {
        name.color
    }

    /**
     Creates a color from a CSS color name string.

     Case-insensitive lookup of CSS color names.

     ```swift
     let coral = Color(name: "coral")
     let navy = Color(name: "Navy")  // case-insensitive
     ```
     */
    public init?(name: String) {
        let lowercased = name.lowercased()
        guard let named = NamedColor.allCases.first(where: {
            $0.rawValue.lowercased() == lowercased ||
            String(describing: $0).lowercased() == lowercased
        }) else {
            return nil
        }
        self = named.color
    }
}
