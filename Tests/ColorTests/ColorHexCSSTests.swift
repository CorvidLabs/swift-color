import Foundation
import Testing
@testable import Color

// MARK: - Hex Parsing

@Suite("Hex String Parsing")
struct HexParsingTests {
    @Test("6-character hex with hash")
    func hex6WithHash() {
        let color = Color(hex: "#FF0000")
        #expect(color != nil)
        #expect(color?.red == 1.0)
        #expect(color?.green == 0.0)
        #expect(color?.blue == 0.0)
        #expect(color?.alpha == 1.0)
    }

    @Test("6-character hex without hash")
    func hex6WithoutHash() {
        let color = Color(hex: "00FF00")
        #expect(color != nil)
        #expect(color?.green == 1.0)
    }

    @Test("6-character hex with 0x prefix")
    func hex6With0x() {
        let color = Color(hex: "0x0000FF")
        #expect(color != nil)
        #expect(color?.blue == 1.0)
    }

    @Test("6-character hex with 0X prefix (uppercase)")
    func hex6With0XUppercase() {
        let color = Color(hex: "0XFF0000")
        #expect(color != nil)
        #expect(color?.red == 1.0)
    }

    @Test("3-character shorthand")
    func hex3Shorthand() {
        let color = Color(hex: "#F00")
        #expect(color != nil)
        #expect(color?.red == 1.0)
        #expect(color?.green == 0.0)
        #expect(color?.blue == 0.0)
    }

    @Test("3-character shorthand expansion")
    func hex3Expansion() {
        // #ABC should expand to #AABBCC
        let color = Color(hex: "#ABC")
        #expect(color != nil)
        #expect(color?.red8 == 0xAA)
        #expect(color?.green8 == 0xBB)
        #expect(color?.blue8 == 0xCC)
    }

    @Test("4-character shorthand with alpha")
    func hex4Shorthand() {
        let color = Color(hex: "#F00F")
        #expect(color != nil)
        #expect(color?.red == 1.0)
        #expect(color?.alpha == 1.0)
    }

    @Test("4-character shorthand half alpha")
    func hex4HalfAlpha() {
        // #F008 -> FF000088 -> alpha = 0x88/255 ≈ 0.533
        let color = Color(hex: "#F008")
        #expect(color != nil)
        #expect(color?.red == 1.0)
        #expect(abs((color?.alpha ?? 0) - Double(0x88) / 255.0) < 0.01)
    }

    @Test("8-character hex with alpha")
    func hex8WithAlpha() {
        let color = Color(hex: "#FF000080")
        #expect(color != nil)
        #expect(color?.red == 1.0)
        #expect(abs((color?.alpha ?? 0) - 0.502) < 0.01)
    }

    @Test("8-character hex full alpha")
    func hex8FullAlpha() {
        let color = Color(hex: "#FF0000FF")
        #expect(color != nil)
        #expect(color?.red == 1.0)
        #expect(color?.alpha == 1.0)
    }

    @Test("8-character hex zero alpha")
    func hex8ZeroAlpha() {
        let color = Color(hex: "#FF000000")
        #expect(color != nil)
        #expect(color?.red == 1.0)
        #expect(color?.alpha == 0.0)
    }

    @Test("Lowercase hex is valid")
    func lowercaseHex() {
        let color = Color(hex: "#ff0000")
        #expect(color != nil)
        #expect(color?.red == 1.0)
    }

    @Test("Mixed case hex is valid")
    func mixedCaseHex() {
        let color = Color(hex: "#Ff00fF")
        #expect(color != nil)
        #expect(color?.red == 1.0)
        #expect(color?.blue == 1.0)
    }

    @Test("Whitespace is trimmed")
    func whitespaceTrimmed() {
        let color = Color(hex: "  #FF0000  ")
        #expect(color != nil)
        #expect(color?.red == 1.0)
    }

    @Test("Invalid hex returns nil")
    func invalidHex() {
        #expect(Color(hex: "invalid") == nil)
        #expect(Color(hex: "#GG0000") == nil)
        #expect(Color(hex: "#FF") == nil)
        #expect(Color(hex: "#FFFFF") == nil) // 5 chars
        #expect(Color(hex: "#FFFFFFFFF") == nil) // 9 chars
        #expect(Color(hex: "") == nil)
        #expect(Color(hex: "#") == nil)
    }

    @Test("Known color hex values")
    func knownHexValues() {
        #expect(Color(hex: "#808080")?.red8 == 128)
        #expect(Color(hex: "#808080")?.green8 == 128)
        #expect(Color(hex: "#808080")?.blue8 == 128)

        #expect(Color(hex: "#C0C0C0")?.red8 == 192)
    }
}

// MARK: - Hex Output

@Suite("Hex String Output")
struct HexOutputTests {
    @Test("Opaque color outputs 6-char hex")
    func opaqueHex() {
        #expect(Color.red.hex == "#FF0000")
        #expect(Color.green.hex == "#00FF00")
        #expect(Color.blue.hex == "#0000FF")
        #expect(Color.white.hex == "#FFFFFF")
        #expect(Color.black.hex == "#000000")
    }

    @Test("Color with alpha outputs 8-char hex")
    func alphaHex() {
        let color = Color.red.withAlpha(0.5)
        #expect(color.hex.count == 9) // # + 8 chars
        #expect(color.hex.hasPrefix("#FF0000"))
    }

    @Test("hexValue has no hash prefix")
    func hexValueNoPrefix() {
        #expect(Color.red.hexValue == "FF0000")
        #expect(!Color.red.hexValue.contains("#"))
    }

    @Test("hexValue with alpha has no hash prefix")
    func hexValueAlphaNoPrefix() {
        let color = Color.red.withAlpha(0.5)
        #expect(!color.hexValue.contains("#"))
        #expect(color.hexValue.hasPrefix("FF0000"))
    }

    @Test("Hex round trip")
    func hexRoundTrip() {
        let hexValues = ["#FF0000", "#00FF00", "#0000FF", "#FFFFFF", "#000000", "#808080"]
        for hex in hexValues {
            let color = Color(hex: hex)!
            #expect(color.hex == hex)
        }
    }
}

// MARK: - CSS rgb()/rgba() Format

@Suite("CSS RGB Format")
struct CSSRGBFormatTests {
    @Test("Opaque color CSS output")
    func opaqueCSS() {
        #expect(Color.red.css == "rgb(255, 0, 0)")
        #expect(Color.blue.css == "rgb(0, 0, 255)")
        #expect(Color.white.css == "rgb(255, 255, 255)")
        #expect(Color.black.css == "rgb(0, 0, 0)")
    }

    @Test("Color with alpha CSS output")
    func alphaCSS() {
        let color = Color.red.withAlpha(0.5)
        #expect(color.css.contains("rgba"))
        #expect(color.css.contains("255"))
        #expect(color.css.contains("0.50"))
    }

    @Test("Parse rgb() string")
    func parseRGB() {
        let color = Color(css: "rgb(255, 128, 0)")
        #expect(color != nil)
        #expect(color?.red == 1.0)
        #expect(abs((color?.green ?? 0) - 128.0 / 255.0) < 0.01)
        #expect(color?.blue == 0.0)
    }

    @Test("Parse rgba() string")
    func parseRGBA() {
        let color = Color(css: "rgba(255, 0, 0, 0.5)")
        #expect(color != nil)
        #expect(color?.red == 1.0)
        #expect(abs((color?.alpha ?? 0) - 0.5) < 0.01)
    }

    @Test("Parse rgb() with spaces")
    func parseWithSpaces() {
        let color = Color(css: "  rgb( 255 , 0 , 0 )  ")
        #expect(color != nil)
        #expect(color?.red == 1.0)
    }

    @Test("Parse rgb() with zero values")
    func parseZero() {
        let color = Color(css: "rgb(0, 0, 0)")
        #expect(color != nil)
        #expect(color?.red == 0.0)
        #expect(color?.green == 0.0)
        #expect(color?.blue == 0.0)
    }

    @Test("Parse rgb() with max values")
    func parseMax() {
        let color = Color(css: "rgb(255, 255, 255)")
        #expect(color != nil)
        #expect(color?.red == 1.0)
        #expect(color?.green == 1.0)
        #expect(color?.blue == 1.0)
    }

    @Test("Invalid CSS returns nil")
    func invalidCSS() {
        #expect(Color(css: "not-a-color") == nil)
        #expect(Color(css: "rgb(abc, 0, 0)") == nil)
        #expect(Color(css: "hsl(0, 100%, 50%)") == nil) // CSS parse only handles rgb/rgba
        #expect(Color(css: "") == nil)
    }

    @Test("CSS round trip")
    func cssRoundTrip() {
        let original = Color(r: 255, g: 128, b: 0)
        let css = original.css
        let restored = Color(css: css)
        #expect(restored != nil)
        #expect(restored?.red8 == original.red8)
        #expect(restored?.green8 == original.green8)
        #expect(restored?.blue8 == original.blue8)
    }
}

// MARK: - CSS hsl()/hsla() Format

@Suite("CSS HSL Format")
struct CSSHSLFormatTests {
    @Test("Opaque color cssHSL output")
    func opaqueCSSHSL() {
        let css = Color.red.cssHSL
        #expect(css.hasPrefix("hsl("))
        #expect(css.contains("0"))
        #expect(css.contains("100%"))
        #expect(css.contains("50%"))
    }

    @Test("Color with alpha cssHSL output")
    func alphaCSSHSL() {
        let color = Color.red.withAlpha(0.5)
        let css = color.cssHSL
        #expect(css.hasPrefix("hsla("))
        #expect(css.contains("0.50"))
    }

    @Test("Blue cssHSL has hue 240")
    func blueCSSHSL() {
        let css = Color.blue.cssHSL
        #expect(css.contains("240"))
    }

    @Test("Green cssHSL has hue 120")
    func greenCSSHSL() {
        let css = Color.green.cssHSL
        #expect(css.contains("120"))
    }

    @Test("Gray cssHSL has 0% saturation")
    func grayCSSHSL() {
        let css = Color.gray.cssHSL
        #expect(css.contains("0%"))
    }
}
