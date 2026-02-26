import Foundation
import Testing
@testable import Color

// MARK: - HSL Conversions

@Suite("HSL Conversion")
struct HSLConversionTests {
    @Test("Red to HSL")
    func redToHSL() {
        let hsl = Color.red.hsl
        #expect(hsl.hue == 0)
        #expect(hsl.saturation == 1.0)
        #expect(hsl.lightness == 0.5)
    }

    @Test("Green to HSL")
    func greenToHSL() {
        let hsl = Color.green.hsl
        #expect(abs(hsl.hue - 120) < 1)
        #expect(hsl.saturation == 1.0)
        #expect(hsl.lightness == 0.5)
    }

    @Test("Blue to HSL")
    func blueToHSL() {
        let hsl = Color.blue.hsl
        #expect(abs(hsl.hue - 240) < 1)
        #expect(hsl.saturation == 1.0)
        #expect(hsl.lightness == 0.5)
    }

    @Test("Yellow to HSL")
    func yellowToHSL() {
        let hsl = Color.yellow.hsl
        #expect(abs(hsl.hue - 60) < 1)
        #expect(hsl.saturation == 1.0)
        #expect(hsl.lightness == 0.5)
    }

    @Test("Cyan to HSL")
    func cyanToHSL() {
        let hsl = Color.cyan.hsl
        #expect(abs(hsl.hue - 180) < 1)
        #expect(hsl.saturation == 1.0)
        #expect(hsl.lightness == 0.5)
    }

    @Test("Magenta to HSL")
    func magentaToHSL() {
        let hsl = Color.magenta.hsl
        #expect(abs(hsl.hue - 300) < 1)
        #expect(hsl.saturation == 1.0)
        #expect(hsl.lightness == 0.5)
    }

    @Test("White to HSL")
    func whiteToHSL() {
        let hsl = Color.white.hsl
        #expect(hsl.saturation == 0)
        #expect(hsl.lightness == 1.0)
    }

    @Test("Black to HSL")
    func blackToHSL() {
        let hsl = Color.black.hsl
        #expect(hsl.saturation == 0)
        #expect(hsl.lightness == 0.0)
    }

    @Test("Gray has zero saturation in HSL")
    func grayHSL() {
        let hsl = Color.gray.hsl
        #expect(hsl.saturation == 0)
        #expect(abs(hsl.lightness - 0.5) < 0.01)
    }

    @Test("HSL to Color round trip for primary colors")
    func hslRoundTrip() {
        for color in [Color.red, Color.green, Color.blue, Color.yellow, Color.cyan, Color.magenta] {
            let hsl = color.hsl
            let restored = Color(hsl: hsl)
            #expect(abs(color.red - restored.red) < 0.01)
            #expect(abs(color.green - restored.green) < 0.01)
            #expect(abs(color.blue - restored.blue) < 0.01)
        }
    }

    @Test("HSL init with parameters")
    func hslParamInit() {
        let color = Color(h: 0, s: 1, l: 0.5)
        #expect(abs(color.red - 1.0) < 0.01)
        #expect(abs(color.green) < 0.01)
        #expect(abs(color.blue) < 0.01)
    }

    @Test("HSL init with alpha")
    func hslWithAlpha() {
        let color = Color(h: 120, s: 1.0, l: 0.5, a: 0.7)
        #expect(abs(color.alpha - 0.7) < 0.01)
        #expect(abs(color.green - 1.0) < 0.01)
    }

    @Test("HSL struct clamping")
    func hslClamping() {
        let hsl = HSL(h: 400, s: 1.5, l: -0.5)
        #expect(hsl.hue >= 0 && hsl.hue < 360)
        #expect(hsl.saturation == 1.0)
        #expect(hsl.lightness == 0.0)
    }

    @Test("HSL achromatic conversion")
    func hslAchromatic() {
        let color = Color(hsl: HSL(h: 0, s: 0, l: 0.5))
        #expect(abs(color.red - 0.5) < 0.01)
        #expect(abs(color.green - 0.5) < 0.01)
        #expect(abs(color.blue - 0.5) < 0.01)
    }

    @Test("HSL hue sectors cover all 60-degree ranges")
    func hslHueSectors() {
        // Test a color in each of the 6 hue sectors
        let sectors: [Double] = [0, 60, 120, 180, 240, 300]
        for hue in sectors {
            let color = Color(h: hue + 15, s: 1.0, l: 0.5)
            let restored = color.hsl
            #expect(abs(restored.hue - (hue + 15)) < 2)
        }
    }
}

// MARK: - HSV Conversions

@Suite("HSV Conversion")
struct HSVConversionTests {
    @Test("Red to HSV")
    func redToHSV() {
        let hsv = Color.red.hsv
        #expect(hsv.hue == 0)
        #expect(hsv.saturation == 1.0)
        #expect(hsv.value == 1.0)
    }

    @Test("Green to HSV")
    func greenToHSV() {
        let hsv = Color.green.hsv
        #expect(abs(hsv.hue - 120) < 1)
        #expect(hsv.saturation == 1.0)
        #expect(hsv.value == 1.0)
    }

    @Test("Blue to HSV")
    func blueToHSV() {
        let hsv = Color.blue.hsv
        #expect(abs(hsv.hue - 240) < 1)
        #expect(hsv.saturation == 1.0)
        #expect(hsv.value == 1.0)
    }

    @Test("White to HSV")
    func whiteToHSV() {
        let hsv = Color.white.hsv
        #expect(hsv.saturation == 0)
        #expect(hsv.value == 1.0)
    }

    @Test("Black to HSV")
    func blackToHSV() {
        let hsv = Color.black.hsv
        #expect(hsv.saturation == 0)
        #expect(hsv.value == 0.0)
    }

    @Test("Gray has zero saturation in HSV")
    func grayHSV() {
        let hsv = Color.gray.hsv
        #expect(hsv.saturation == 0)
        #expect(abs(hsv.value - 0.5) < 0.01)
    }

    @Test("HSV to Color round trip for primary colors")
    func hsvRoundTrip() {
        for color in [Color.red, Color.green, Color.blue, Color.yellow, Color.cyan, Color.magenta] {
            let hsv = color.hsv
            let restored = Color(hsv: hsv)
            #expect(abs(color.red - restored.red) < 0.01)
            #expect(abs(color.green - restored.green) < 0.01)
            #expect(abs(color.blue - restored.blue) < 0.01)
        }
    }

    @Test("HSV init with parameters")
    func hsvParamInit() {
        let color = Color(h: 0, s: 1, v: 1)
        #expect(abs(color.red - 1.0) < 0.01)
        #expect(abs(color.green) < 0.01)
        #expect(abs(color.blue) < 0.01)
    }

    @Test("HSV init with alpha")
    func hsvWithAlpha() {
        let color = Color(h: 240, s: 1.0, v: 1.0, a: 0.3)
        #expect(abs(color.alpha - 0.3) < 0.01)
        #expect(abs(color.blue - 1.0) < 0.01)
    }

    @Test("HSV struct clamping")
    func hsvClamping() {
        let hsv = HSV(h: 400, s: 1.5, v: -0.5)
        #expect(hsv.hue >= 0 && hsv.hue < 360)
        #expect(hsv.saturation == 1.0)
        #expect(hsv.value == 0.0)
    }

    @Test("HSV achromatic conversion")
    func hsvAchromatic() {
        let color = Color(hsv: HSV(h: 0, s: 0, v: 0.7))
        #expect(abs(color.red - 0.7) < 0.01)
        #expect(abs(color.green - 0.7) < 0.01)
        #expect(abs(color.blue - 0.7) < 0.01)
    }

    @Test("HSV hue sectors cover all 60-degree ranges")
    func hsvHueSectors() {
        let sectors: [Double] = [0, 60, 120, 180, 240, 300]
        for hue in sectors {
            let color = Color(h: hue + 15, s: 1.0, v: 1.0)
            let restored = color.hsv
            #expect(abs(restored.hue - (hue + 15)) < 2)
        }
    }
}

// MARK: - LAB Conversions

@Suite("LAB Conversion")
struct LABConversionTests {
    @Test("Red to LAB")
    func redToLAB() {
        let lab = Color.red.lab
        #expect(lab.lightness > 50)
        #expect(lab.a > 0) // Red is positive on a axis
        #expect(lab.b > 0) // Red is positive on b axis
    }

    @Test("Green to LAB")
    func greenToLAB() {
        let lab = Color.green.lab
        #expect(lab.lightness > 80) // Green is very light
        #expect(lab.a < 0) // Green is negative on a axis
    }

    @Test("Blue to LAB")
    func blueToLAB() {
        let lab = Color.blue.lab
        #expect(lab.lightness < 40) // Blue is relatively dark
        #expect(lab.b < 0) // Blue is negative on b axis
    }

    @Test("White to LAB")
    func whiteToLAB() {
        let lab = Color.white.lab
        #expect(abs(lab.lightness - 100) < 1)
        #expect(abs(lab.a) < 1)
        #expect(abs(lab.b) < 1)
    }

    @Test("Black to LAB")
    func blackToLAB() {
        let lab = Color.black.lab
        #expect(abs(lab.lightness) < 1)
        #expect(abs(lab.a) < 1)
        #expect(abs(lab.b) < 1)
    }

    @Test("LAB round trip for primary colors")
    func labRoundTrip() {
        for color in [Color.red, Color.green, Color.blue, Color.white, Color.black] {
            let lab = color.lab
            let restored = Color(lab: lab)
            #expect(abs(color.red - restored.red) < 0.02)
            #expect(abs(color.green - restored.green) < 0.02)
            #expect(abs(color.blue - restored.blue) < 0.02)
        }
    }

    @Test("LAB init with parameters")
    func labParamInit() {
        let color = Color(l: 50, a: 0, b: 0) // Mid gray
        #expect(abs(color.red - color.green) < 0.01)
        #expect(abs(color.green - color.blue) < 0.01)
    }

    @Test("LAB init with alpha")
    func labWithAlpha() {
        let color = Color(l: 50, a: 0, b: 0, alpha: 0.5)
        #expect(abs(color.alpha - 0.5) < 0.01)
    }

    @Test("LAB struct initialization clamps lightness")
    func labClamping() {
        let lab = LAB(l: 150, a: 50, b: 50)
        #expect(lab.lightness == 100)

        let labNeg = LAB(l: -10, a: 50, b: 50)
        #expect(labNeg.lightness == 0)
    }

    @Test("Delta E between identical colors is zero")
    func deltaEIdentical() {
        let de = Color.red.deltaE(from: .red)
        #expect(abs(de) < 0.01)
    }

    @Test("Delta E between very different colors is large")
    func deltaEDifferent() {
        let de = Color.red.deltaE(from: .blue)
        #expect(de > 100)
    }

    @Test("Delta E between similar colors is small")
    func deltaESimilar() {
        let color1 = Color(r: 1.0, g: 0.0, b: 0.0)
        let color2 = Color(r: 0.98, g: 0.0, b: 0.0)
        let de = color1.deltaE(from: color2)
        #expect(de < 5)
    }

    @Test("Delta E is symmetric")
    func deltaESymmetric() {
        let de1 = Color.red.deltaE(from: .blue)
        let de2 = Color.blue.deltaE(from: .red)
        #expect(abs(de1 - de2) < 0.01)
    }

    @Test("mixLAB produces intermediate color")
    func mixLAB() {
        let mixed = Color.black.mixLAB(with: .white, ratio: 0.5)
        #expect(mixed.red > 0.3 && mixed.red < 0.7)
        #expect(mixed.green > 0.3 && mixed.green < 0.7)
        #expect(mixed.blue > 0.3 && mixed.blue < 0.7)
    }

    @Test("mixLAB at ratio 0 returns original")
    func mixLABZeroRatio() {
        let mixed = Color.red.mixLAB(with: .blue, ratio: 0)
        #expect(abs(mixed.red - Color.red.red) < 0.01)
        #expect(abs(mixed.green - Color.red.green) < 0.01)
        #expect(abs(mixed.blue - Color.red.blue) < 0.01)
    }

    @Test("mixLAB at ratio 1 returns other color")
    func mixLABOneRatio() {
        let mixed = Color.red.mixLAB(with: .blue, ratio: 1.0)
        #expect(abs(mixed.red - Color.blue.red) < 0.02)
        #expect(abs(mixed.green - Color.blue.green) < 0.02)
        #expect(abs(mixed.blue - Color.blue.blue) < 0.02)
    }

    @Test("mixLAB clamps ratio")
    func mixLABClampRatio() {
        let mixed1 = Color.red.mixLAB(with: .blue, ratio: -0.5)
        let mixed2 = Color.red.mixLAB(with: .blue, ratio: 0.0)
        #expect(abs(mixed1.red - mixed2.red) < 0.01)

        let mixed3 = Color.red.mixLAB(with: .blue, ratio: 1.5)
        let mixed4 = Color.red.mixLAB(with: .blue, ratio: 1.0)
        #expect(abs(mixed3.red - mixed4.red) < 0.01)
    }

    @Test("mixLAB interpolates alpha")
    func mixLABAlpha() {
        let c1 = Color.red.withAlpha(0.0)
        let c2 = Color.blue.withAlpha(1.0)
        let mixed = c1.mixLAB(with: c2, ratio: 0.5)
        #expect(abs(mixed.alpha - 0.5) < 0.01)
    }
}

// MARK: - LCH Conversions

@Suite("LCH Conversion")
struct LCHConversionTests {
    @Test("Red to LCH")
    func redToLCH() {
        let lch = Color.red.lch
        #expect(lch.lightness > 50)
        #expect(lch.chroma > 50) // Red is highly chromatic
        #expect(lch.hue >= 0 && lch.hue < 360)
    }

    @Test("White to LCH has zero chroma")
    func whiteToLCH() {
        let lch = Color.white.lch
        #expect(abs(lch.lightness - 100) < 1)
        #expect(abs(lch.chroma) < 1) // Achromatic
    }

    @Test("Black to LCH has zero chroma")
    func blackToLCH() {
        let lch = Color.black.lch
        #expect(abs(lch.lightness) < 1)
        #expect(abs(lch.chroma) < 1) // Achromatic
    }

    @Test("LCH round trip for primary colors")
    func lchRoundTrip() {
        for color in [Color.red, Color.green, Color.blue] {
            let lch = color.lch
            let restored = Color(lch: lch)
            #expect(abs(color.red - restored.red) < 0.02)
            #expect(abs(color.green - restored.green) < 0.02)
            #expect(abs(color.blue - restored.blue) < 0.02)
        }
    }

    @Test("LCH init with parameters")
    func lchParamInit() {
        let color = Color(l: 50, c: 0, h: 0)
        // Zero chroma should produce a neutral gray
        #expect(abs(color.red - color.green) < 0.01)
        #expect(abs(color.green - color.blue) < 0.01)
    }

    @Test("LCH init with alpha")
    func lchWithAlpha() {
        let color = Color(l: 50, c: 50, h: 0, alpha: 0.6)
        #expect(abs(color.alpha - 0.6) < 0.01)
    }

    @Test("LCH struct initialization clamps")
    func lchClamping() {
        let lch = LCH(l: 150, c: -10, h: 400)
        #expect(lch.lightness == 100)
        #expect(lch.chroma == 0)
        #expect(lch.hue >= 0 && lch.hue < 360)
    }

    @Test("LCH is cylindrical form of LAB")
    func lchIsLabCylindrical() {
        let color = Color.red
        let lab = color.lab
        let lch = color.lch

        // Lightness should match
        #expect(abs(lab.lightness - lch.lightness) < 0.01)

        // Chroma should be sqrt(a^2 + b^2)
        let expectedChroma = sqrt(lab.a * lab.a + lab.b * lab.b)
        #expect(abs(lch.chroma - expectedChroma) < 0.01)
    }
}

// MARK: - Cross-Space Conversions

@Suite("Cross-Space Color Conversions")
struct CrossSpaceConversionTests {
    @Test("HSL and HSV agree on hue for saturated colors")
    func hslHsvHueAgreement() {
        for color in [Color.red, Color.green, Color.blue, Color.yellow, Color.cyan, Color.magenta] {
            let hsl = color.hsl
            let hsv = color.hsv
            #expect(abs(hsl.hue - hsv.hue) < 1)
        }
    }

    @Test("HSL lightness 0 is black")
    func hslBlack() {
        let color = Color(h: 0, s: 1.0, l: 0.0)
        #expect(color.red == 0.0)
        #expect(color.green == 0.0)
        #expect(color.blue == 0.0)
    }

    @Test("HSL lightness 1 is white")
    func hslWhite() {
        let color = Color(h: 0, s: 1.0, l: 1.0)
        #expect(abs(color.red - 1.0) < 0.01)
        #expect(abs(color.green - 1.0) < 0.01)
        #expect(abs(color.blue - 1.0) < 0.01)
    }

    @Test("HSV value 0 is black")
    func hsvBlack() {
        let color = Color(h: 0, s: 1.0, v: 0.0)
        #expect(color.red == 0.0)
        #expect(color.green == 0.0)
        #expect(color.blue == 0.0)
    }

    @Test("Round trip: RGB -> HSL -> RGB -> HSV -> RGB preserves color")
    func multiSpaceRoundTrip() {
        let original = Color(r: 0.3, g: 0.6, b: 0.9)
        let viaHSL = Color(hsl: original.hsl)
        let viaHSV = Color(hsv: viaHSL.hsv)
        #expect(abs(original.red - viaHSV.red) < 0.02)
        #expect(abs(original.green - viaHSV.green) < 0.02)
        #expect(abs(original.blue - viaHSV.blue) < 0.02)
    }
}
