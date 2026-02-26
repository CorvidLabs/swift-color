import Foundation
import Testing
@testable import Color

// MARK: - Core RGB Initialization

@Suite("RGB Double Initialization")
struct RGBDoubleInitTests {
    @Test("Standard RGB values")
    func standardRGB() {
        let color = Color(r: 0.25, g: 0.5, b: 0.75)
        #expect(color.red == 0.25)
        #expect(color.green == 0.5)
        #expect(color.blue == 0.75)
        #expect(color.alpha == 1.0)
    }

    @Test("RGB with explicit alpha")
    func rgbWithAlpha() {
        let color = Color(r: 1.0, g: 0.0, b: 0.0, a: 0.5)
        #expect(color.red == 1.0)
        #expect(color.green == 0.0)
        #expect(color.blue == 0.0)
        #expect(color.alpha == 0.5)
    }

    @Test("All zeros produces black")
    func allZeros() {
        let color = Color(r: 0.0, g: 0.0, b: 0.0)
        #expect(color == Color.black)
    }

    @Test("All ones produces white")
    func allOnes() {
        let color = Color(r: 1.0, g: 1.0, b: 1.0)
        #expect(color == Color.white)
    }

    @Test("Alpha defaults to 1.0")
    func defaultAlpha() {
        let color = Color(r: 0.5, g: 0.5, b: 0.5)
        #expect(color.alpha == 1.0)
    }
}

// MARK: - 8-bit RGB Initialization

@Suite("RGB 8-bit Initialization")
struct RGB8BitInitTests {
    @Test("Standard 8-bit values")
    func standard8Bit() {
        let color = Color(r: 255, g: 128, b: 0)
        #expect(color.red == 1.0)
        #expect(abs(color.green - 128.0 / 255.0) < 0.001)
        #expect(color.blue == 0.0)
    }

    @Test("8-bit alpha defaults to 255")
    func default8BitAlpha() {
        let color = Color(r: 128, g: 128, b: 128)
        #expect(color.alpha == 1.0)
    }

    @Test("8-bit alpha specified")
    func specified8BitAlpha() {
        let color = Color(r: 255, g: 0, b: 0, a: 128)
        #expect(abs(color.alpha - 128.0 / 255.0) < 0.001)
    }

    @Test("8-bit zero values")
    func zero8Bit() {
        let color = Color(r: 0, g: 0, b: 0)
        #expect(color.red == 0.0)
        #expect(color.green == 0.0)
        #expect(color.blue == 0.0)
    }

    @Test("8-bit max values")
    func max8Bit() {
        let color = Color(r: 255, g: 255, b: 255, a: 255)
        #expect(color.red == 1.0)
        #expect(color.green == 1.0)
        #expect(color.blue == 1.0)
        #expect(color.alpha == 1.0)
    }

    @Test("8-bit mid values")
    func mid8Bit() {
        let color = Color(r: 128, g: 64, b: 192)
        #expect(abs(color.red - 128.0 / 255.0) < 0.001)
        #expect(abs(color.green - 64.0 / 255.0) < 0.001)
        #expect(abs(color.blue - 192.0 / 255.0) < 0.001)
    }
}

// MARK: - Clamping

@Suite("RGB Clamping")
struct RGBClampingTests {
    @Test("Values above 1.0 are clamped")
    func clampAbove() {
        let color = Color(r: 1.5, g: 2.0, b: 100.0)
        #expect(color.red == 1.0)
        #expect(color.green == 1.0)
        #expect(color.blue == 1.0)
    }

    @Test("Values below 0.0 are clamped")
    func clampBelow() {
        let color = Color(r: -0.5, g: -1.0, b: -100.0)
        #expect(color.red == 0.0)
        #expect(color.green == 0.0)
        #expect(color.blue == 0.0)
    }

    @Test("Alpha is also clamped")
    func clampAlpha() {
        let above = Color(r: 0.5, g: 0.5, b: 0.5, a: 1.5)
        #expect(above.alpha == 1.0)

        let below = Color(r: 0.5, g: 0.5, b: 0.5, a: -0.5)
        #expect(below.alpha == 0.0)
    }

    @Test("Mixed clamping - some in range, some out")
    func mixedClamping() {
        let color = Color(r: 1.5, g: 0.5, b: -0.5, a: 0.75)
        #expect(color.red == 1.0)
        #expect(color.green == 0.5)
        #expect(color.blue == 0.0)
        #expect(color.alpha == 0.75)
    }

    @Test("Boundary values are preserved")
    func boundaryValues() {
        let color = Color(r: 0.0, g: 1.0, b: 0.0, a: 0.0)
        #expect(color.red == 0.0)
        #expect(color.green == 1.0)
        #expect(color.blue == 0.0)
        #expect(color.alpha == 0.0)
    }
}

// MARK: - 8-bit Component Properties

@Suite("8-bit Component Access")
struct ComponentAccessTests {
    @Test("8-bit components for pure colors")
    func pureColor8Bit() {
        #expect(Color.red.red8 == 255)
        #expect(Color.red.green8 == 0)
        #expect(Color.red.blue8 == 0)
        #expect(Color.red.alpha8 == 255)
    }

    @Test("8-bit components for mid-range values")
    func midRange8Bit() {
        let color = Color(r: 0.5, g: 0.5, b: 0.5)
        #expect(color.red8 == 128)
        #expect(color.green8 == 128)
        #expect(color.blue8 == 128)
    }

    @Test("8-bit alpha component")
    func alpha8Bit() {
        let color = Color(r: 1.0, g: 0.0, b: 0.0, a: 0.0)
        #expect(color.alpha8 == 0)

        let halfAlpha = Color(r: 1.0, g: 0.0, b: 0.0, a: 0.5)
        #expect(halfAlpha.alpha8 == 128)
    }

    @Test("8-bit boundary rounding")
    func boundaryRounding() {
        let color = Color(r: 0.0, g: 0.0, b: 0.0)
        #expect(color.red8 == 0)
        #expect(color.green8 == 0)
        #expect(color.blue8 == 0)

        let white = Color(r: 1.0, g: 1.0, b: 1.0)
        #expect(white.red8 == 255)
        #expect(white.green8 == 255)
        #expect(white.blue8 == 255)
    }
}

// MARK: - Static Colors

@Suite("Static Color Constants")
struct StaticColorTests {
    @Test("Black is (0,0,0)")
    func black() {
        #expect(Color.black.red == 0.0)
        #expect(Color.black.green == 0.0)
        #expect(Color.black.blue == 0.0)
        #expect(Color.black.alpha == 1.0)
    }

    @Test("White is (1,1,1)")
    func white() {
        #expect(Color.white.red == 1.0)
        #expect(Color.white.green == 1.0)
        #expect(Color.white.blue == 1.0)
        #expect(Color.white.alpha == 1.0)
    }

    @Test("Red is (1,0,0)")
    func red() {
        #expect(Color.red.red == 1.0)
        #expect(Color.red.green == 0.0)
        #expect(Color.red.blue == 0.0)
    }

    @Test("Green is (0,1,0)")
    func green() {
        #expect(Color.green.red == 0.0)
        #expect(Color.green.green == 1.0)
        #expect(Color.green.blue == 0.0)
    }

    @Test("Blue is (0,0,1)")
    func blue() {
        #expect(Color.blue.red == 0.0)
        #expect(Color.blue.green == 0.0)
        #expect(Color.blue.blue == 1.0)
    }

    @Test("Yellow is (1,1,0)")
    func yellow() {
        #expect(Color.yellow.red == 1.0)
        #expect(Color.yellow.green == 1.0)
        #expect(Color.yellow.blue == 0.0)
    }

    @Test("Cyan is (0,1,1)")
    func cyan() {
        #expect(Color.cyan.red == 0.0)
        #expect(Color.cyan.green == 1.0)
        #expect(Color.cyan.blue == 1.0)
    }

    @Test("Magenta is (1,0,1)")
    func magenta() {
        #expect(Color.magenta.red == 1.0)
        #expect(Color.magenta.green == 0.0)
        #expect(Color.magenta.blue == 1.0)
    }

    @Test("Gray is (0.5, 0.5, 0.5)")
    func gray() {
        #expect(Color.gray.red == 0.5)
        #expect(Color.gray.green == 0.5)
        #expect(Color.gray.blue == 0.5)
    }

    @Test("Clear has zero alpha")
    func clear() {
        #expect(Color.clear.alpha == 0.0)
        #expect(Color.clear.red == 0.0)
        #expect(Color.clear.green == 0.0)
        #expect(Color.clear.blue == 0.0)
    }

    @Test("Static colors hex values")
    func staticColorHex() {
        #expect(Color.black.hex == "#000000")
        #expect(Color.white.hex == "#FFFFFF")
        #expect(Color.red.hex == "#FF0000")
        #expect(Color.green.hex == "#00FF00")
        #expect(Color.blue.hex == "#0000FF")
        #expect(Color.yellow.hex == "#FFFF00")
        #expect(Color.cyan.hex == "#00FFFF")
        #expect(Color.magenta.hex == "#FF00FF")
    }
}

// MARK: - withAlpha

@Suite("withAlpha Method")
struct WithAlphaTests {
    @Test("Set alpha on opaque color")
    func setAlpha() {
        let color = Color.red.withAlpha(0.5)
        #expect(color.red == 1.0)
        #expect(color.green == 0.0)
        #expect(color.blue == 0.0)
        #expect(color.alpha == 0.5)
    }

    @Test("Set alpha to zero")
    func setAlphaZero() {
        let color = Color.blue.withAlpha(0.0)
        #expect(color.alpha == 0.0)
        #expect(color.blue == 1.0)
    }

    @Test("Set alpha to one on transparent color")
    func setAlphaOne() {
        let clear = Color.clear
        let opaque = clear.withAlpha(1.0)
        #expect(opaque.alpha == 1.0)
    }

    @Test("withAlpha clamps values")
    func withAlphaClamping() {
        let above = Color.red.withAlpha(1.5)
        #expect(above.alpha == 1.0)

        let below = Color.red.withAlpha(-0.5)
        #expect(below.alpha == 0.0)
    }

    @Test("withAlpha preserves RGB components")
    func preservesRGB() {
        let original = Color(r: 0.2, g: 0.4, b: 0.6)
        let modified = original.withAlpha(0.3)
        #expect(modified.red == original.red)
        #expect(modified.green == original.green)
        #expect(modified.blue == original.blue)
    }
}
