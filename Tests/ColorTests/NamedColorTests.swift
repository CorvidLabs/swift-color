import Foundation
import Testing
@testable import Color

// MARK: - Named Color Creation

@Suite("Named Color Creation")
struct NamedColorCreationTests {
    @Test("Create color from named enum")
    func namedEnum() {
        let coral = Color.named(.coral)
        #expect(coral.hex == "#FF7F50")
    }

    @Test("All primary colors match expected hex")
    func primaryColors() {
        #expect(Color.named(.red).hex == "#FF0000")
        #expect(Color.named(.blue).hex == "#0000FF")
        #expect(Color.named(.green).hex == "#008000") // CSS green is #008000, not #00FF00
        #expect(Color.named(.white).hex == "#FFFFFF")
        #expect(Color.named(.black).hex == "#000000")
    }

    @Test("Named color property returns valid Color")
    func namedColorProperty() {
        let coral = NamedColor.coral
        let color = coral.color
        #expect(color.red8 == 0xFF)
        #expect(color.green8 == 0x7F)
        #expect(color.blue8 == 0x50)
    }

    @Test("All named colors produce valid hex colors")
    func allNamedColorsValid() {
        for named in NamedColor.allCases {
            let color = Color(hex: named.hex)
            #expect(color != nil, "Named color \(named) has invalid hex: \(named.hex)")
        }
    }

    @Test("Spot-check various named color hex values")
    func spotCheckHex() {
        #expect(NamedColor.indianRed.hex == "CD5C5C")
        #expect(NamedColor.hotPink.hex == "FF69B4")
        #expect(NamedColor.gold.hex == "FFD700")
        #expect(NamedColor.navy.hex == "000080")
        #expect(NamedColor.teal.hex == "008080")
        #expect(NamedColor.sienna.hex == "A0522D")
        #expect(NamedColor.lavender.hex == "E6E6FA")
        #expect(NamedColor.steelBlue.hex == "4682B4")
    }
}

// MARK: - Named Color Aliases

@Suite("Named Color Aliases")
struct NamedColorAliasTests {
    @Test("Magenta is alias for fuchsia")
    func magentaAlias() {
        #expect(NamedColor.magenta == .fuchsia)
        #expect(NamedColor.magenta.hex == NamedColor.fuchsia.hex)
    }

    @Test("Cyan is alias for aqua")
    func cyanAlias() {
        #expect(NamedColor.cyan == .aqua)
        #expect(NamedColor.cyan.hex == NamedColor.aqua.hex)
    }

    @Test("Fuchsia hex is FF00FF")
    func fuchsiaHex() {
        #expect(NamedColor.fuchsia.hex == "FF00FF")
    }

    @Test("Aqua hex is 00FFFF")
    func aquaHex() {
        #expect(NamedColor.aqua.hex == "00FFFF")
    }
}

// MARK: - String Name Lookup

@Suite("Named Color String Lookup")
struct NamedColorLookupTests {
    @Test("Lookup by exact case name")
    func exactCase() {
        let coral = Color(name: "coral")
        #expect(coral != nil)
        #expect(coral?.hex == "#FF7F50")
    }

    @Test("Lookup is case insensitive")
    func caseInsensitive() {
        let coral1 = Color(name: "coral")
        let coral2 = Color(name: "CORAL")
        let coral3 = Color(name: "Coral")
        #expect(coral1 != nil)
        #expect(coral2 != nil)
        #expect(coral3 != nil)
        #expect(coral1 == coral2)
        #expect(coral2 == coral3)
    }

    @Test("Invalid name returns nil")
    func invalidName() {
        #expect(Color(name: "notacolor") == nil)
        #expect(Color(name: "") == nil)
        #expect(Color(name: "redd") == nil)
    }

    @Test("Lookup common CSS colors by name")
    func commonCSSColors() {
        #expect(Color(name: "red") != nil)
        #expect(Color(name: "blue") != nil)
        #expect(Color(name: "green") != nil)
        #expect(Color(name: "white") != nil)
        #expect(Color(name: "black") != nil)
        #expect(Color(name: "orange") != nil)
        #expect(Color(name: "purple") != nil)
        #expect(Color(name: "yellow") != nil)
    }

    @Test("Lookup camelCase named colors")
    func camelCaseNames() {
        #expect(Color(name: "lightCoral") != nil)
        #expect(Color(name: "darkSlateGray") != nil)
        #expect(Color(name: "mediumSpringGreen") != nil)
        #expect(Color(name: "deepSkyBlue") != nil)
    }

    @Test("Lookup returns correct color for steelBlue")
    func steelBlueLookup() {
        let color = Color(name: "steelBlue")
        #expect(color != nil)
        #expect(color?.red8 == 0x46)
        #expect(color?.green8 == 0x82)
        #expect(color?.blue8 == 0xB4)
    }
}

// MARK: - Named Color Categories

@Suite("Named Color Categories")
struct NamedColorCategoryTests {
    @Test("Red family colors have high red component")
    func redFamily() {
        let reds: [NamedColor] = [.red, .crimson, .fireBrick, .darkRed]
        for named in reds {
            let color = named.color
            #expect(color.red > color.green)
            #expect(color.red > color.blue)
        }
    }

    @Test("Blue family colors have high blue component")
    func blueFamily() {
        let blues: [NamedColor] = [.blue, .navy, .darkBlue, .mediumBlue, .midnightBlue]
        for named in blues {
            let color = named.color
            #expect(color.blue >= color.red)
            #expect(color.blue >= color.green)
        }
    }

    @Test("Gray family colors have equal RGB")
    func grayFamily() {
        let grays: [NamedColor] = [.gray, .silver, .darkGray, .lightGray, .dimGray]
        for named in grays {
            let color = named.color
            // Grays should have approximately equal R, G, B
            #expect(abs(color.red - color.green) < 0.05)
            #expect(abs(color.green - color.blue) < 0.05)
        }
    }

    @Test("White family colors are light")
    func whiteFamily() {
        let whites: [NamedColor] = [.white, .snow, .ivory, .ghostWhite, .whiteSmoke]
        for named in whites {
            let color = named.color
            #expect(color.luminance > 0.9)
        }
    }

    @Test("Total named color count is 140")
    func totalCount() {
        #expect(NamedColor.allCases.count == 140)
    }
}

// MARK: - Named Color to Color Consistency

@Suite("Named Color Consistency")
struct NamedColorConsistencyTests {
    @Test("Named color via enum matches string lookup")
    func enumMatchesStringLookup() {
        let enumColor = Color.named(.coral)
        let stringColor = Color(name: "coral")!
        #expect(enumColor == stringColor)
    }

    @Test("Named color hex matches direct hex init")
    func hexMatchesDirectInit() {
        for named in NamedColor.allCases {
            let fromNamed = named.color
            let fromHex = Color(hex: named.hex)!
            #expect(fromNamed == fromHex)
        }
    }

    @Test("Color.named static method produces same as .color property")
    func staticMatchesProperty() {
        for named in NamedColor.allCases {
            let fromStatic = Color.named(named)
            let fromProperty = named.color
            #expect(fromStatic == fromProperty)
        }
    }
}
