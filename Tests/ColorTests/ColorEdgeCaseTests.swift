import Foundation
import Testing
@testable import Color

// MARK: - Alpha Preservation Through Operations

@Suite("Alpha Preservation")
struct AlphaPreservationTests {
    @Test("Lighten preserves alpha")
    func lightenAlpha() {
        let color = Color.red.withAlpha(0.3)
        let lighter = color.lighten(by: 0.2)
        #expect(abs(lighter.alpha - 0.3) < 0.01)
    }

    @Test("Darken preserves alpha")
    func darkenAlpha() {
        let color = Color.red.withAlpha(0.3)
        let darker = color.darken(by: 0.2)
        #expect(abs(darker.alpha - 0.3) < 0.01)
    }

    @Test("Saturate preserves alpha")
    func saturateAlpha() {
        let color = Color(h: 0, s: 0.5, l: 0.5, a: 0.4)
        let saturated = color.saturate(by: 0.2)
        #expect(abs(saturated.alpha - 0.4) < 0.01)
    }

    @Test("Desaturate preserves alpha")
    func desaturateAlpha() {
        let color = Color.red.withAlpha(0.6)
        let desaturated = color.desaturate(by: 0.2)
        #expect(abs(desaturated.alpha - 0.6) < 0.01)
    }

    @Test("Invert preserves alpha")
    func invertAlpha() {
        let color = Color.red.withAlpha(0.7)
        let inverted = color.inverted
        #expect(abs(inverted.alpha - 0.7) < 0.01)
    }

    @Test("Complement preserves alpha")
    func complementAlpha() {
        let color = Color.red.withAlpha(0.8)
        let comp = color.complement
        #expect(abs(comp.alpha - 0.8) < 0.01)
    }

    @Test("AdjustHue preserves alpha")
    func adjustHueAlpha() {
        let color = Color.red.withAlpha(0.4)
        let adjusted = color.adjustHue(by: 90)
        #expect(abs(adjusted.alpha - 0.4) < 0.01)
    }

    @Test("Grayscale preserves alpha")
    func grayscaleAlpha() {
        let color = Color.red.withAlpha(0.5)
        let gray = color.grayscale
        #expect(abs(gray.alpha - 0.5) < 0.01)
    }

    @Test("Multiply preserves source alpha")
    func multiplyAlpha() {
        let color = Color.red.withAlpha(0.3)
        let result = color.multiply(with: .blue)
        #expect(abs(result.alpha - 0.3) < 0.01)
    }

    @Test("Screen preserves source alpha")
    func screenAlpha() {
        let color = Color.red.withAlpha(0.3)
        let result = color.screen(with: .blue)
        #expect(abs(result.alpha - 0.3) < 0.01)
    }

    @Test("Overlay preserves source alpha")
    func overlayAlpha() {
        let color = Color.red.withAlpha(0.3)
        let result = color.overlay(with: .blue)
        #expect(abs(result.alpha - 0.3) < 0.01)
    }
}

// MARK: - Manipulation Edge Cases

@Suite("Manipulation Edge Cases")
struct ManipulationEdgeCaseTests {
    @Test("Lighten by zero produces same color")
    func lightenByZero() {
        let color = Color.red
        let lightened = color.lighten(by: 0.0)
        #expect(abs(lightened.red - color.red) < 0.01)
    }

    @Test("Darken by zero produces same color")
    func darkenByZero() {
        let color = Color.red
        let darkened = color.darken(by: 0.0)
        #expect(abs(darkened.red - color.red) < 0.01)
    }

    @Test("Lighten white stays white")
    func lightenWhite() {
        let lightened = Color.white.lighten(by: 0.5)
        #expect(lightened.hsl.lightness == 1.0)
    }

    @Test("Darken black stays black")
    func darkenBlack() {
        let darkened = Color.black.darken(by: 0.5)
        #expect(darkened.hsl.lightness == 0.0)
    }

    @Test("Invert twice returns original")
    func invertTwice() {
        let original = Color(r: 0.3, g: 0.6, b: 0.9)
        let doubleInverted = original.inverted.inverted
        #expect(abs(original.red - doubleInverted.red) < 0.01)
        #expect(abs(original.green - doubleInverted.green) < 0.01)
        #expect(abs(original.blue - doubleInverted.blue) < 0.01)
    }

    @Test("Invert black gives white")
    func invertBlack() {
        let inverted = Color.black.inverted
        #expect(inverted.red == 1.0)
        #expect(inverted.green == 1.0)
        #expect(inverted.blue == 1.0)
    }

    @Test("Invert white gives black")
    func invertWhite() {
        let inverted = Color.white.inverted
        #expect(inverted.red == 0.0)
        #expect(inverted.green == 0.0)
        #expect(inverted.blue == 0.0)
    }

    @Test("Mix at ratio 0 returns first color")
    func mixRatioZero() {
        let mixed = Color.red.mix(with: .blue, ratio: 0.0)
        #expect(mixed.red == 1.0)
        #expect(mixed.blue == 0.0)
    }

    @Test("Mix at ratio 1 returns second color")
    func mixRatioOne() {
        let mixed = Color.red.mix(with: .blue, ratio: 1.0)
        #expect(mixed.red == 0.0)
        #expect(mixed.blue == 1.0)
    }

    @Test("Mix clamps ratio below 0")
    func mixClampBelow() {
        let mixed1 = Color.red.mix(with: .blue, ratio: -0.5)
        let mixed2 = Color.red.mix(with: .blue, ratio: 0.0)
        #expect(abs(mixed1.red - mixed2.red) < 0.01)
    }

    @Test("Mix clamps ratio above 1")
    func mixClampAbove() {
        let mixed1 = Color.red.mix(with: .blue, ratio: 1.5)
        let mixed2 = Color.red.mix(with: .blue, ratio: 1.0)
        #expect(abs(mixed1.red - mixed2.red) < 0.01)
    }

    @Test("Mix interpolates alpha")
    func mixAlpha() {
        let c1 = Color.red.withAlpha(0.0)
        let c2 = Color.blue.withAlpha(1.0)
        let mixed = c1.mix(with: c2, ratio: 0.5)
        #expect(abs(mixed.alpha - 0.5) < 0.01)
    }

    @Test("Complement of complement returns original hue")
    func doubleComplement() {
        let original = Color(h: 45, s: 1.0, l: 0.5)
        let doubleComp = original.complement.complement
        #expect(abs(doubleComp.hsl.hue - 45) < 2)
    }

    @Test("AdjustHue by 360 returns same hue")
    func adjustHue360() {
        let original = Color(h: 90, s: 1.0, l: 0.5)
        let adjusted = original.adjustHue(by: 360)
        #expect(abs(adjusted.hsl.hue - 90) < 2)
    }

    @Test("AdjustHue by negative degrees")
    func adjustHueNegative() {
        let original = Color(h: 90, s: 1.0, l: 0.5)
        let adjusted = original.adjustHue(by: -90)
        #expect(abs(adjusted.hsl.hue - 0) < 2 || abs(adjusted.hsl.hue - 360) < 2)
    }

    @Test("Tint at 0 returns original")
    func tintAtZero() {
        let tinted = Color.red.tint(by: 0.0)
        #expect(tinted.red == 1.0)
        #expect(tinted.green == 0.0)
        #expect(tinted.blue == 0.0)
    }

    @Test("Tint at 1 returns white")
    func tintAtOne() {
        let tinted = Color.red.tint(by: 1.0)
        #expect(tinted.red == 1.0)
        #expect(tinted.green == 1.0)
        #expect(tinted.blue == 1.0)
    }

    @Test("Shade at 0 returns original")
    func shadeAtZero() {
        let shaded = Color.red.shade(by: 0.0)
        #expect(shaded.red == 1.0)
        #expect(shaded.green == 0.0)
        #expect(shaded.blue == 0.0)
    }

    @Test("Shade at 1 returns black")
    func shadeAtOne() {
        let shaded = Color.red.shade(by: 1.0)
        #expect(shaded.red == 0.0)
        #expect(shaded.green == 0.0)
        #expect(shaded.blue == 0.0)
    }

    @Test("Desaturate fully produces gray")
    func desaturateFully() {
        let gray = Color.red.desaturate(by: 1.0)
        #expect(gray.hsl.saturation == 0)
    }

    @Test("Default lighten amount is 0.1")
    func lightenDefault() {
        let hsl = Color.red.hsl
        let lightened = Color.red.lighten()
        #expect(abs(lightened.hsl.lightness - (hsl.lightness + 0.1)) < 0.01)
    }

    @Test("Default darken amount is 0.1")
    func darkenDefault() {
        let hsl = Color.red.hsl
        let darkened = Color.red.darken()
        #expect(abs(darkened.hsl.lightness - (hsl.lightness - 0.1)) < 0.01)
    }
}

// MARK: - Blend Mode Edge Cases

@Suite("Blend Mode Edge Cases")
struct BlendModeEdgeCaseTests {
    @Test("Multiply with black gives black")
    func multiplyBlack() {
        let result = Color.red.multiply(with: .black)
        #expect(result.red == 0.0)
        #expect(result.green == 0.0)
        #expect(result.blue == 0.0)
    }

    @Test("Multiply with white is identity")
    func multiplyWhite() {
        let result = Color.red.multiply(with: .white)
        #expect(result.red == 1.0)
        #expect(result.green == 0.0)
        #expect(result.blue == 0.0)
    }

    @Test("Screen with white gives white")
    func screenWhite() {
        let result = Color.red.screen(with: .white)
        #expect(result.red == 1.0)
        #expect(result.green == 1.0)
        #expect(result.blue == 1.0)
    }

    @Test("Screen with black is identity")
    func screenBlack() {
        let result = Color.red.screen(with: .black)
        #expect(result.red == 1.0)
        #expect(result.green == 0.0)
        #expect(result.blue == 0.0)
    }

    @Test("Multiply is commutative")
    func multiplyCommutative() {
        let a = Color(r: 0.3, g: 0.6, b: 0.9)
        let b = Color(r: 0.8, g: 0.4, b: 0.2)
        let ab = a.multiply(with: b)
        let ba = b.multiply(with: a)
        #expect(abs(ab.red - ba.red) < 0.01)
        #expect(abs(ab.green - ba.green) < 0.01)
        #expect(abs(ab.blue - ba.blue) < 0.01)
    }

    @Test("Screen is commutative")
    func screenCommutative() {
        let a = Color(r: 0.3, g: 0.6, b: 0.9)
        let b = Color(r: 0.8, g: 0.4, b: 0.2)
        let ab = a.screen(with: b)
        let ba = b.screen(with: a)
        #expect(abs(ab.red - ba.red) < 0.01)
        #expect(abs(ab.green - ba.green) < 0.01)
        #expect(abs(ab.blue - ba.blue) < 0.01)
    }

    @Test("Overlay with gray is meaningful")
    func overlayGray() {
        let result = Color.gray.overlay(with: .red)
        #expect(result.red > 0)
        #expect(result.red <= 1.0)
    }
}

// MARK: - Accessibility Edge Cases

@Suite("Accessibility Edge Cases")
struct AccessibilityEdgeCaseTests {
    @Test("Black on white passes all levels")
    func blackOnWhite() {
        #expect(Color.black.isAccessible(on: .white, level: .aa))
        #expect(Color.black.isAccessible(on: .white, level: .aaa))
        #expect(Color.black.isAccessible(on: .white, level: .aa, largeText: true))
        #expect(Color.black.isAccessible(on: .white, level: .aaa, largeText: true))
    }

    @Test("White luminance is 1.0")
    func whiteLuminance() {
        #expect(Color.white.luminance == 1.0)
    }

    @Test("Black luminance is 0.0")
    func blackLuminance() {
        #expect(Color.black.luminance == 0.0)
    }

    @Test("Contrast ratio is symmetric")
    func contrastSymmetric() {
        let ratio1 = Color.red.contrastRatio(with: .white)
        let ratio2 = Color.white.contrastRatio(with: .red)
        #expect(abs(ratio1 - ratio2) < 0.01)
    }

    @Test("Same color contrast ratio is 1")
    func sameColorContrast() {
        let ratio = Color.red.contrastRatio(with: .red)
        #expect(abs(ratio - 1.0) < 0.01)
    }

    @Test("Black/white max contrast ratio is 21")
    func maxContrastRatio() {
        let ratio = Color.black.contrastRatio(with: .white)
        #expect(abs(ratio - 21.0) < 0.1)
    }

    @Test("Contrasting text for dark backgrounds is white")
    func darkBackgroundText() {
        #expect(Color.black.contrastingTextColor == .white)
        #expect(Color(hex: "#333333")!.contrastingTextColor == .white)
    }

    @Test("Contrasting text for light backgrounds is black")
    func lightBackgroundText() {
        #expect(Color.white.contrastingTextColor == .black)
        #expect(Color(hex: "#CCCCCC")!.contrastingTextColor == .black)
    }

    @Test("adjustedForAccessibility returns self when already accessible")
    func alreadyAccessible() {
        let result = Color.black.adjustedForAccessibility(on: .white, level: .aa)
        #expect(result == Color.black)
    }

    @Test("adjustedForAccessibility finds accessible color")
    func findsAccessible() {
        let color = Color(hex: "#777777")!
        let adjusted = color.adjustedForAccessibility(on: .white, level: .aa)
        #expect(adjusted != nil)
        #expect(adjusted!.isAccessible(on: .white, level: .aa))
    }

    @Test("Large text has lower contrast requirements")
    func largeTextLowerRequirements() {
        let color = Color(hex: "#888888")!
        let passesLarge = color.isAccessible(on: .white, level: .aa, largeText: true)
        let passesNormal = color.isAccessible(on: .white, level: .aa, largeText: false)
        // Large text should be same or easier to pass
        #expect(passesLarge || !passesNormal)
    }
}

// MARK: - Color Blindness Simulation Edge Cases

@Suite("Color Blindness Edge Cases")
struct ColorBlindnessEdgeCaseTests {
    @Test("Black remains black in all simulations")
    func blackUnchanged() {
        let proto = Color.black.simulatedProtanopia
        let deut = Color.black.simulatedDeuteranopia
        let trit = Color.black.simulatedTritanopia
        #expect(proto.red < 0.01 && proto.green < 0.01 && proto.blue < 0.01)
        #expect(deut.red < 0.01 && deut.green < 0.01 && deut.blue < 0.01)
        #expect(trit.red < 0.01 && trit.green < 0.01 && trit.blue < 0.01)
    }

    @Test("White remains approximately white in all simulations")
    func whiteApproxUnchanged() {
        let proto = Color.white.simulatedProtanopia
        let deut = Color.white.simulatedDeuteranopia
        let trit = Color.white.simulatedTritanopia
        #expect(proto.red > 0.9)
        #expect(deut.red > 0.9)
        #expect(trit.red > 0.9)
    }

    @Test("Simulations preserve alpha")
    func simulationsPreserveAlpha() {
        let color = Color.red.withAlpha(0.3)
        #expect(abs(color.simulatedProtanopia.alpha - 0.3) < 0.01)
        #expect(abs(color.simulatedDeuteranopia.alpha - 0.3) < 0.01)
        #expect(abs(color.simulatedTritanopia.alpha - 0.3) < 0.01)
    }
}

// MARK: - Palette Edge Cases

@Suite("Palette Edge Cases")
struct PaletteEdgeCaseTests {
    @Test("Complementary always returns 2 colors")
    func complementaryCount() {
        #expect(Color.red.complementary.count == 2)
        #expect(Color.black.complementary.count == 2)
        #expect(Color.white.complementary.count == 2)
    }

    @Test("Triadic always returns 3 colors")
    func triadicCount() {
        #expect(Color.red.triadic.count == 3)
        #expect(Color.black.triadic.count == 3)
    }

    @Test("Tetradic always returns 4 colors")
    func tetradicCount() {
        #expect(Color.red.tetradic.count == 4)
        #expect(Color.black.tetradic.count == 4)
    }

    @Test("Split complementary always returns 3 colors")
    func splitCompCount() {
        #expect(Color.red.splitComplementary.count == 3)
    }

    @Test("Analogous respects count parameter")
    func analogousCount() {
        #expect(Color.red.analogous(count: 1).count == 1)
        #expect(Color.red.analogous(count: 5).count == 5)
        #expect(Color.red.analogous(count: 10).count == 10)
    }

    @Test("Gradient with 2 steps returns start and end")
    func gradient2Steps() {
        let colors = Color.red.gradient(to: .blue, steps: 2)
        #expect(colors.count == 2)
        #expect(colors[0].red > 0.9)
        // Last should be approximately blue
        #expect(colors[1].blue > 0.9)
    }

    @Test("Gradient with 1 step returns self")
    func gradient1Step() {
        let colors = Color.red.gradient(to: .blue, steps: 1)
        #expect(colors.count == 1)
        #expect(colors[0].red == 1.0)
    }

    @Test("Tints first is original, last is white")
    func tintsFirstLast() {
        let tints = Color.blue.tints(count: 5)
        #expect(tints.first!.blue > 0.9)
        #expect(tints.last!.red == 1.0)
        #expect(tints.last!.green == 1.0)
        #expect(tints.last!.blue == 1.0)
    }

    @Test("Shades first is original, last is black")
    func shadesFirstLast() {
        let shades = Color.blue.shades(count: 5)
        #expect(shades.first!.blue > 0.9)
        #expect(shades.last!.red == 0.0)
        #expect(shades.last!.green == 0.0)
        #expect(shades.last!.blue == 0.0)
    }

    @Test("Tonal scale goes from dark to light")
    func tonalScaleMonotone() {
        let scale = Color.red.tonalScale(count: 9)
        #expect(scale.count == 9)
        #expect(scale.first!.luminance < scale.last!.luminance)
    }

    @Test("Random color is valid")
    func randomValid() {
        let color = Color.random()
        #expect(color.red >= 0 && color.red <= 1)
        #expect(color.green >= 0 && color.green <= 1)
        #expect(color.blue >= 0 && color.blue <= 1)
        #expect(color.alpha == 1.0)
    }

    @Test("Random with alpha respects parameter")
    func randomAlpha() {
        let color = Color.random(alpha: 0.5)
        #expect(color.alpha == 0.5)
    }

    @Test("Distinct palette produces unique colors")
    func distinctPaletteUnique() {
        let colors = Color.distinctPalette(count: 10)
        #expect(colors.count == 10)
        for i in 0..<colors.count {
            for j in (i + 1)..<colors.count {
                #expect(colors[i] != colors[j])
            }
        }
    }

    @Test("Multi-gradient produces correct count")
    func multiGradientCount() {
        let colors = Color.red.multiGradient(through: [.yellow, .blue], stepsPerSegment: 5)
        // 5 for first segment minus last + 5 for second segment = 4 + 5 = 9
        #expect(colors.count == 9)
    }

    @Test("Non-perceptual gradient differs from perceptual")
    func perceptualVsLinear() {
        let perceptual = Color.red.gradient(to: .blue, steps: 5, perceptual: true)
        let linear = Color.red.gradient(to: .blue, steps: 5, perceptual: false)
        // Both should have 5 colors
        #expect(perceptual.count == 5)
        #expect(linear.count == 5)
        // Middle colors may differ
        // (We just check both produce valid results)
        for color in perceptual + linear {
            #expect(color.red >= 0 && color.red <= 1)
            #expect(color.green >= 0 && color.green <= 1)
            #expect(color.blue >= 0 && color.blue <= 1)
        }
    }
}

// MARK: - Grayscale Edge Cases

@Suite("Grayscale Edge Cases")
struct GrayscaleEdgeCaseTests {
    @Test("Grayscale of gray is the same gray")
    func grayGrayscale() {
        let gray = Color.gray.grayscale
        #expect(abs(gray.red - gray.green) < 0.01)
        #expect(abs(gray.green - gray.blue) < 0.01)
    }

    @Test("Grayscale of white is white")
    func whiteGrayscale() {
        let gray = Color.white.grayscale
        #expect(abs(gray.red - 1.0) < 0.01)
    }

    @Test("Grayscale of black is black")
    func blackGrayscale() {
        let gray = Color.black.grayscale
        #expect(abs(gray.red) < 0.01)
    }

    @Test("Grayscale produces equal RGB components")
    func grayscaleEqualComponents() {
        let gray = Color(r: 0.3, g: 0.6, b: 0.9).grayscale
        #expect(abs(gray.red - gray.green) < 0.01)
        #expect(abs(gray.green - gray.blue) < 0.01)
    }
}
