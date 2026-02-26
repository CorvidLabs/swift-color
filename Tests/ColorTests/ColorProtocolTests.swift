import Foundation
import Testing
@testable import Color

// MARK: - Equatable Conformance

@Suite("Equatable Conformance")
struct EquatableTests {
    @Test("Same colors are equal")
    func sameColorsEqual() {
        let a = Color(r: 0.5, g: 0.3, b: 0.7, a: 0.9)
        let b = Color(r: 0.5, g: 0.3, b: 0.7, a: 0.9)
        #expect(a == b)
    }

    @Test("Different colors are not equal")
    func differentColorsNotEqual() {
        #expect(Color.red != Color.blue)
        #expect(Color.red != Color.green)
        #expect(Color.white != Color.black)
    }

    @Test("Colors differing only in alpha are not equal")
    func alphaDifference() {
        let opaque = Color(r: 1.0, g: 0.0, b: 0.0, a: 1.0)
        let transparent = Color(r: 1.0, g: 0.0, b: 0.0, a: 0.5)
        #expect(opaque != transparent)
    }

    @Test("Static colors equal themselves")
    func staticSelfEquality() {
        #expect(Color.red == Color.red)
        #expect(Color.blue == Color.blue)
        #expect(Color.black == Color.black)
        #expect(Color.white == Color.white)
        #expect(Color.clear == Color.clear)
    }

    @Test("Colors from different init paths are equal")
    func differentInitPathsEqual() {
        let fromDouble = Color(r: 1.0, g: 0.0, b: 0.0)
        let fromHex = Color(hex: "#FF0000")!
        #expect(fromDouble == fromHex)
    }
}

// MARK: - Hashable Conformance

@Suite("Hashable Conformance")
struct HashableTests {
    @Test("Equal colors have same hash")
    func equalColorsHashEqual() {
        let a = Color(r: 0.5, g: 0.3, b: 0.7)
        let b = Color(r: 0.5, g: 0.3, b: 0.7)
        #expect(a.hashValue == b.hashValue)
    }

    @Test("Color as dictionary key")
    func dictionaryKey() {
        var dict: [Color: String] = [:]
        dict[.red] = "red"
        dict[.blue] = "blue"
        dict[.green] = "green"
        #expect(dict.count == 3)
        #expect(dict[.red] == "red")
        #expect(dict[.blue] == "blue")
        #expect(dict[.green] == "green")
    }

    @Test("Color in Set")
    func colorInSet() {
        var set = Set<Color>()
        set.insert(.red)
        set.insert(.blue)
        set.insert(.green)
        #expect(set.count == 3)
        #expect(set.contains(.red))
        #expect(set.contains(.blue))
        #expect(set.contains(.green))
    }

    @Test("Set deduplicates equal colors")
    func setDeduplication() {
        var set = Set<Color>()
        set.insert(Color(r: 1.0, g: 0.0, b: 0.0))
        set.insert(Color(r: 1.0, g: 0.0, b: 0.0))
        set.insert(Color.red)
        #expect(set.count == 1)
    }

    @Test("HSL struct is Hashable")
    func hslHashable() {
        let a = HSL(h: 0, s: 1, l: 0.5)
        let b = HSL(h: 0, s: 1, l: 0.5)
        #expect(a.hashValue == b.hashValue)

        var set = Set<HSL>()
        set.insert(a)
        set.insert(b)
        #expect(set.count == 1)
    }

    @Test("HSV struct is Hashable")
    func hsvHashable() {
        let a = HSV(h: 120, s: 1, v: 1)
        let b = HSV(h: 120, s: 1, v: 1)
        #expect(a.hashValue == b.hashValue)

        var set = Set<HSV>()
        set.insert(a)
        set.insert(b)
        #expect(set.count == 1)
    }

    @Test("LAB struct is Hashable")
    func labHashable() {
        let a = LAB(l: 50, a: 25, b: -10)
        let b = LAB(l: 50, a: 25, b: -10)
        #expect(a.hashValue == b.hashValue)

        var set = Set<LAB>()
        set.insert(a)
        set.insert(b)
        #expect(set.count == 1)
    }

    @Test("LCH struct is Hashable")
    func lchHashable() {
        let a = LCH(l: 50, c: 30, h: 180)
        let b = LCH(l: 50, c: 30, h: 180)
        #expect(a.hashValue == b.hashValue)

        var set = Set<LCH>()
        set.insert(a)
        set.insert(b)
        #expect(set.count == 1)
    }
}

// MARK: - Codable Conformance

@Suite("Codable Conformance")
struct CodableTests {
    @Test("Encode and decode Color")
    func codableRoundTrip() throws {
        let original = Color(r: 0.5, g: 0.25, b: 0.75, a: 0.9)
        let encoded = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Color.self, from: encoded)
        #expect(decoded == original)
    }

    @Test("Encode pure red")
    func encodePureRed() throws {
        let encoded = try JSONEncoder().encode(Color.red)
        let decoded = try JSONDecoder().decode(Color.self, from: encoded)
        #expect(decoded == Color.red)
    }

    @Test("Encode color with alpha")
    func encodeWithAlpha() throws {
        let original = Color(r: 1.0, g: 0.0, b: 0.0, a: 0.5)
        let encoded = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(Color.self, from: encoded)
        #expect(decoded.alpha == 0.5)
        #expect(decoded.red == 1.0)
    }

    @Test("Encode clear color")
    func encodeClear() throws {
        let encoded = try JSONEncoder().encode(Color.clear)
        let decoded = try JSONDecoder().decode(Color.self, from: encoded)
        #expect(decoded == Color.clear)
    }

    @Test("Encode all static colors")
    func encodeAllStatic() throws {
        let colors: [Color] = [.black, .white, .red, .green, .blue, .yellow, .cyan, .magenta, .clear, .gray]
        for color in colors {
            let encoded = try JSONEncoder().encode(color)
            let decoded = try JSONDecoder().decode(Color.self, from: encoded)
            #expect(decoded == color)
        }
    }

    @Test("Encode as array")
    func encodeAsArray() throws {
        let colors = [Color.red, Color.green, Color.blue]
        let encoded = try JSONEncoder().encode(colors)
        let decoded = try JSONDecoder().decode([Color].self, from: encoded)
        #expect(decoded.count == 3)
        #expect(decoded[0] == Color.red)
        #expect(decoded[1] == Color.green)
        #expect(decoded[2] == Color.blue)
    }

    @Test("JSON contains expected keys")
    func jsonKeys() throws {
        let color = Color(r: 1.0, g: 0.5, b: 0.0, a: 0.8)
        let encoded = try JSONEncoder().encode(color)
        let json = try JSONSerialization.jsonObject(with: encoded) as? [String: Any]
        #expect(json != nil)
        // Verify the JSON can be round-tripped
        let decoded = try JSONDecoder().decode(Color.self, from: encoded)
        #expect(decoded == color)
    }
}

// MARK: - CustomStringConvertible

@Suite("CustomStringConvertible Conformance")
struct StringDescriptionTests {
    @Test("Opaque color description")
    func opaqueDescription() {
        let desc = Color.red.description
        #expect(desc.contains("Color"))
        #expect(desc.contains("r:"))
        #expect(desc.contains("g:"))
        #expect(desc.contains("b:"))
        #expect(!desc.contains("a:"))
    }

    @Test("Color with alpha description includes alpha")
    func alphaDescription() {
        let desc = Color.red.withAlpha(0.5).description
        #expect(desc.contains("a:"))
        #expect(desc.contains("0.5"))
    }

    @Test("Clear color description includes alpha")
    func clearDescription() {
        let desc = Color.clear.description
        #expect(desc.contains("a:"))
    }

    @Test("Description includes actual component values")
    func descriptionValues() {
        let color = Color(r: 0.25, g: 0.5, b: 0.75)
        let desc = color.description
        #expect(desc.contains("0.25"))
        #expect(desc.contains("0.5"))
        #expect(desc.contains("0.75"))
    }

    @Test("Opaque color has no alpha in description")
    func opaqueNoAlpha() {
        let desc = Color.white.description
        #expect(!desc.contains("a:"))
    }

    @Test("String interpolation works")
    func stringInterpolation() {
        let color = Color.red
        let str = "Color is: \(color)"
        #expect(str.contains("Color("))
    }
}

// MARK: - Sendable Conformance

@Suite("Sendable Conformance")
struct SendableTests {
    @Test("Color is Sendable")
    func colorSendable() async {
        // Verify Color can be passed across concurrency boundaries
        let color = Color.red
        let result = await Task {
            return color
        }.value
        #expect(result == Color.red)
    }

    @Test("HSL is Sendable")
    func hslSendable() async {
        let hsl = HSL(h: 0, s: 1, l: 0.5)
        let result = await Task {
            return hsl
        }.value
        #expect(result == HSL(h: 0, s: 1, l: 0.5))
    }

    @Test("HSV is Sendable")
    func hsvSendable() async {
        let hsv = HSV(h: 120, s: 1, v: 1)
        let result = await Task {
            return hsv
        }.value
        #expect(result == HSV(h: 120, s: 1, v: 1))
    }

    @Test("LAB is Sendable")
    func labSendable() async {
        let lab = LAB(l: 50, a: 25, b: -10)
        let result = await Task {
            return lab
        }.value
        #expect(result == LAB(l: 50, a: 25, b: -10))
    }

    @Test("LCH is Sendable")
    func lchSendable() async {
        let lch = LCH(l: 50, c: 30, h: 180)
        let result = await Task {
            return lch
        }.value
        #expect(result == LCH(l: 50, c: 30, h: 180))
    }

    @Test("NamedColor is Sendable")
    func namedColorSendable() async {
        let named = NamedColor.coral
        let result = await Task {
            return named
        }.value
        #expect(result == NamedColor.coral)
    }

    @Test("WCAGLevel is Sendable")
    func wcagLevelSendable() async {
        let level = WCAGLevel.aa
        let result = await Task {
            return level
        }.value
        #expect(result == WCAGLevel.aa)
    }

    @Test("Color can be used in concurrent collection")
    func colorConcurrentCollection() async {
        let colors: [Color] = [.red, .green, .blue, .yellow, .cyan]
        let results = await withTaskGroup(of: Color.self) { group in
            for color in colors {
                group.addTask {
                    return color.withAlpha(0.5)
                }
            }
            var collected: [Color] = []
            for await result in group {
                collected.append(result)
            }
            return collected
        }
        #expect(results.count == 5)
        for result in results {
            #expect(result.alpha == 0.5)
        }
    }
}

// MARK: - WCAGLevel Enum

@Suite("WCAGLevel Enum")
struct WCAGLevelTests {
    @Test("AA normal text ratio")
    func aaNormalText() {
        #expect(WCAGLevel.aa.normalTextRatio == 4.5)
    }

    @Test("AA large text ratio")
    func aaLargeText() {
        #expect(WCAGLevel.aa.largeTextRatio == 3.0)
    }

    @Test("AAA normal text ratio")
    func aaaNormalText() {
        #expect(WCAGLevel.aaa.normalTextRatio == 7.0)
    }

    @Test("AAA large text ratio")
    func aaaLargeText() {
        #expect(WCAGLevel.aaa.largeTextRatio == 4.5)
    }

    @Test("AAA is stricter than AA")
    func aaaStricterThanAA() {
        #expect(WCAGLevel.aaa.normalTextRatio > WCAGLevel.aa.normalTextRatio)
        #expect(WCAGLevel.aaa.largeTextRatio > WCAGLevel.aa.largeTextRatio)
    }
}

// MARK: - NamedColor Enum Conformances

@Suite("NamedColor Enum Conformances")
struct NamedColorEnumTests {
    @Test("NamedColor is CaseIterable")
    func caseIterable() {
        #expect(NamedColor.allCases.count == 140)
    }

    @Test("NamedColor rawValue is hex string")
    func rawValueIsHex() {
        #expect(NamedColor.red.rawValue == "FF0000")
        #expect(NamedColor.blue.rawValue == "0000FF")
        #expect(NamedColor.green.rawValue == "008000")
    }

    @Test("NamedColor init from rawValue")
    func initFromRawValue() {
        let named = NamedColor(rawValue: "FF0000")
        #expect(named == .red)

        let invalid = NamedColor(rawValue: "INVALID")
        #expect(invalid == nil)
    }

    @Test("NamedColor hex property matches rawValue")
    func hexMatchesRawValue() {
        for named in NamedColor.allCases {
            #expect(named.hex == named.rawValue)
        }
    }
}
