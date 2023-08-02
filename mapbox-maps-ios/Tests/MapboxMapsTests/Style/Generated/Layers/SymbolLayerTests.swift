// This file is generated
import XCTest
@_spi(Experimental) @testable import MapboxMaps

final class SymbolLayerTests: XCTestCase {

    func testLayerProtocolMembers() {

        var layer = SymbolLayer(id: "test-id", source: "source")
        layer.minZoom = 10.0
        layer.maxZoom = 20.0

        XCTAssertEqual(layer.id, "test-id")
        XCTAssertEqual(layer.type, LayerType.symbol)
        XCTAssertEqual(layer.minZoom, 10.0)
        XCTAssertEqual(layer.maxZoom, 20.0)
    }

    func testEncodingAndDecodingOfLayerProtocolProperties() {
        var layer = SymbolLayer(id: "test-id", source: "source")
        layer.minZoom = 10.0
        layer.maxZoom = 20.0

        var data: Data?
        do {
            data = try JSONEncoder().encode(layer)
        } catch {
            XCTFail("Failed to encode SymbolLayer")
        }

        guard let validData = data else {
            XCTFail("Failed to encode SymbolLayer")
            return
        }

        do {
            let decodedLayer = try JSONDecoder().decode(SymbolLayer.self, from: validData)
            XCTAssertEqual(decodedLayer.id, "test-id")
            XCTAssertEqual(decodedLayer.type, LayerType.symbol)
            XCTAssert(decodedLayer.source == "source")
            XCTAssertEqual(decodedLayer.minZoom, 10.0)
            XCTAssertEqual(decodedLayer.maxZoom, 20.0)
        } catch {
            XCTFail("Failed to decode SymbolLayer")
        }
    }

    func testEncodingAndDecodingOfLayoutProperties() {
        var layer = SymbolLayer(id: "test-id", source: "source")
        layer.visibility = .constant(.visible)
        layer.iconAllowOverlap = Value<Bool>.testConstantValue()
        layer.iconAnchor = Value<IconAnchor>.testConstantValue()
        layer.iconIgnorePlacement = Value<Bool>.testConstantValue()
        layer.iconImage = Value<ResolvedImage>.testConstantValue()
        layer.iconKeepUpright = Value<Bool>.testConstantValue()
        layer.iconOffset = Value<[Double]>.testConstantValue()
        layer.iconOptional = Value<Bool>.testConstantValue()
        layer.iconPadding = Value<Double>.testConstantValue()
        layer.iconPitchAlignment = Value<IconPitchAlignment>.testConstantValue()
        layer.iconRotate = Value<Double>.testConstantValue()
        layer.iconRotationAlignment = Value<IconRotationAlignment>.testConstantValue()
        layer.iconSize = Value<Double>.testConstantValue()
        layer.iconTextFit = Value<IconTextFit>.testConstantValue()
        layer.iconTextFitPadding = Value<[Double]>.testConstantValue()
        layer.symbolAvoidEdges = Value<Bool>.testConstantValue()
        layer.symbolPlacement = Value<SymbolPlacement>.testConstantValue()
        layer.symbolSortKey = Value<Double>.testConstantValue()
        layer.symbolSpacing = Value<Double>.testConstantValue()
        layer.symbolZOrder = Value<SymbolZOrder>.testConstantValue()
        layer.textAllowOverlap = Value<Bool>.testConstantValue()
        layer.textAnchor = Value<TextAnchor>.testConstantValue()
        layer.textField = Value<String>.testConstantValue()
        layer.textFont = Value<[String]>.testConstantValue()
        layer.textIgnorePlacement = Value<Bool>.testConstantValue()
        layer.textJustify = Value<TextJustify>.testConstantValue()
        layer.textKeepUpright = Value<Bool>.testConstantValue()
        layer.textLetterSpacing = Value<Double>.testConstantValue()
        layer.textLineHeight = Value<Double>.testConstantValue()
        layer.textMaxAngle = Value<Double>.testConstantValue()
        layer.textMaxWidth = Value<Double>.testConstantValue()
        layer.textOffset = Value<[Double]>.testConstantValue()
        layer.textOptional = Value<Bool>.testConstantValue()
        layer.textPadding = Value<Double>.testConstantValue()
        layer.textPitchAlignment = Value<TextPitchAlignment>.testConstantValue()
        layer.textRadialOffset = Value<Double>.testConstantValue()
        layer.textRotate = Value<Double>.testConstantValue()
        layer.textRotationAlignment = Value<TextRotationAlignment>.testConstantValue()
        layer.textSize = Value<Double>.testConstantValue()
        layer.textTransform = Value<TextTransform>.testConstantValue()
        layer.textVariableAnchor = Value<[TextAnchor]>.testConstantValue()
        layer.textWritingMode = Value<[TextWritingMode]>.testConstantValue()

        var data: Data?
        do {
            data = try JSONEncoder().encode(layer)
        } catch {
            XCTFail("Failed to encode SymbolLayer")
        }

        guard let validData = data else {
            XCTFail("Failed to encode SymbolLayer")
            return
        }

        do {
            let decodedLayer = try JSONDecoder().decode(SymbolLayer.self, from: validData)
            XCTAssert(decodedLayer.visibility == .constant(.visible))
            XCTAssertEqual(layer.iconAllowOverlap, Value<Bool>.testConstantValue())
            XCTAssertEqual(layer.iconAnchor, Value<IconAnchor>.testConstantValue())
            XCTAssertEqual(layer.iconIgnorePlacement, Value<Bool>.testConstantValue())
            XCTAssertEqual(layer.iconImage, Value<ResolvedImage>.testConstantValue())
            XCTAssertEqual(layer.iconKeepUpright, Value<Bool>.testConstantValue())
            XCTAssertEqual(layer.iconOffset, Value<[Double]>.testConstantValue())
            XCTAssertEqual(layer.iconOptional, Value<Bool>.testConstantValue())
            XCTAssertEqual(layer.iconPadding, Value<Double>.testConstantValue())
            XCTAssertEqual(layer.iconPitchAlignment, Value<IconPitchAlignment>.testConstantValue())
            XCTAssertEqual(layer.iconRotate, Value<Double>.testConstantValue())
            XCTAssertEqual(layer.iconRotationAlignment, Value<IconRotationAlignment>.testConstantValue())
            XCTAssertEqual(layer.iconSize, Value<Double>.testConstantValue())
            XCTAssertEqual(layer.iconTextFit, Value<IconTextFit>.testConstantValue())
            XCTAssertEqual(layer.iconTextFitPadding, Value<[Double]>.testConstantValue())
            XCTAssertEqual(layer.symbolAvoidEdges, Value<Bool>.testConstantValue())
            XCTAssertEqual(layer.symbolPlacement, Value<SymbolPlacement>.testConstantValue())
            XCTAssertEqual(layer.symbolSortKey, Value<Double>.testConstantValue())
            XCTAssertEqual(layer.symbolSpacing, Value<Double>.testConstantValue())
            XCTAssertEqual(layer.symbolZOrder, Value<SymbolZOrder>.testConstantValue())
            XCTAssertEqual(layer.textAllowOverlap, Value<Bool>.testConstantValue())
            XCTAssertEqual(layer.textAnchor, Value<TextAnchor>.testConstantValue())
            XCTAssertEqual(layer.textField, Value<String>.testConstantValue())
            XCTAssertEqual(layer.textFont, Value<[String]>.testConstantValue())
            XCTAssertEqual(layer.textIgnorePlacement, Value<Bool>.testConstantValue())
            XCTAssertEqual(layer.textJustify, Value<TextJustify>.testConstantValue())
            XCTAssertEqual(layer.textKeepUpright, Value<Bool>.testConstantValue())
            XCTAssertEqual(layer.textLetterSpacing, Value<Double>.testConstantValue())
            XCTAssertEqual(layer.textLineHeight, Value<Double>.testConstantValue())
            XCTAssertEqual(layer.textMaxAngle, Value<Double>.testConstantValue())
            XCTAssertEqual(layer.textMaxWidth, Value<Double>.testConstantValue())
            XCTAssertEqual(layer.textOffset, Value<[Double]>.testConstantValue())
            XCTAssertEqual(layer.textOptional, Value<Bool>.testConstantValue())
            XCTAssertEqual(layer.textPadding, Value<Double>.testConstantValue())
            XCTAssertEqual(layer.textPitchAlignment, Value<TextPitchAlignment>.testConstantValue())
            XCTAssertEqual(layer.textRadialOffset, Value<Double>.testConstantValue())
            XCTAssertEqual(layer.textRotate, Value<Double>.testConstantValue())
            XCTAssertEqual(layer.textRotationAlignment, Value<TextRotationAlignment>.testConstantValue())
            XCTAssertEqual(layer.textSize, Value<Double>.testConstantValue())
            XCTAssertEqual(layer.textTransform, Value<TextTransform>.testConstantValue())
            XCTAssertEqual(layer.textVariableAnchor, Value<[TextAnchor]>.testConstantValue())
            XCTAssertEqual(layer.textWritingMode, Value<[TextWritingMode]>.testConstantValue())
        } catch {
            XCTFail("Failed to decode SymbolLayer")
        }
    }

    func testEncodingAndDecodingOfPaintProperties() {
       var layer = SymbolLayer(id: "test-id", source: "source")
       layer.iconColor = Value<StyleColor>.testConstantValue()
       layer.iconColorTransition = StyleTransition(duration: 10.0, delay: 10.0)
       layer.iconEmissiveStrength = Value<Double>.testConstantValue()
       layer.iconEmissiveStrengthTransition = StyleTransition(duration: 10.0, delay: 10.0)
       layer.iconHaloBlur = Value<Double>.testConstantValue()
       layer.iconHaloBlurTransition = StyleTransition(duration: 10.0, delay: 10.0)
       layer.iconHaloColor = Value<StyleColor>.testConstantValue()
       layer.iconHaloColorTransition = StyleTransition(duration: 10.0, delay: 10.0)
       layer.iconHaloWidth = Value<Double>.testConstantValue()
       layer.iconHaloWidthTransition = StyleTransition(duration: 10.0, delay: 10.0)
       layer.iconImageCrossFade = Value<Double>.testConstantValue()
       layer.iconImageCrossFadeTransition = StyleTransition(duration: 10.0, delay: 10.0)
       layer.iconOpacity = Value<Double>.testConstantValue()
       layer.iconOpacityTransition = StyleTransition(duration: 10.0, delay: 10.0)
       layer.iconTranslate = Value<[Double]>.testConstantValue()
       layer.iconTranslateTransition = StyleTransition(duration: 10.0, delay: 10.0)
       layer.iconTranslateAnchor = Value<IconTranslateAnchor>.testConstantValue()
       layer.textColor = Value<StyleColor>.testConstantValue()
       layer.textColorTransition = StyleTransition(duration: 10.0, delay: 10.0)
       layer.textEmissiveStrength = Value<Double>.testConstantValue()
       layer.textEmissiveStrengthTransition = StyleTransition(duration: 10.0, delay: 10.0)
       layer.textHaloBlur = Value<Double>.testConstantValue()
       layer.textHaloBlurTransition = StyleTransition(duration: 10.0, delay: 10.0)
       layer.textHaloColor = Value<StyleColor>.testConstantValue()
       layer.textHaloColorTransition = StyleTransition(duration: 10.0, delay: 10.0)
       layer.textHaloWidth = Value<Double>.testConstantValue()
       layer.textHaloWidthTransition = StyleTransition(duration: 10.0, delay: 10.0)
       layer.textOpacity = Value<Double>.testConstantValue()
       layer.textOpacityTransition = StyleTransition(duration: 10.0, delay: 10.0)
       layer.textTranslate = Value<[Double]>.testConstantValue()
       layer.textTranslateTransition = StyleTransition(duration: 10.0, delay: 10.0)
       layer.textTranslateAnchor = Value<TextTranslateAnchor>.testConstantValue()

       var data: Data?
       do {
           data = try JSONEncoder().encode(layer)
       } catch {
           XCTFail("Failed to encode SymbolLayer")
       }

       guard let validData = data else {
           XCTFail("Failed to encode SymbolLayer")
           return
       }

       do {
           let decodedLayer = try JSONDecoder().decode(SymbolLayer.self, from: validData)
           XCTAssert(decodedLayer.visibility == .constant(.visible))
           XCTAssertEqual(layer.iconColor, Value<StyleColor>.testConstantValue())
           XCTAssertEqual(layer.iconEmissiveStrength, Value<Double>.testConstantValue())
           XCTAssertEqual(layer.iconHaloBlur, Value<Double>.testConstantValue())
           XCTAssertEqual(layer.iconHaloColor, Value<StyleColor>.testConstantValue())
           XCTAssertEqual(layer.iconHaloWidth, Value<Double>.testConstantValue())
           XCTAssertEqual(layer.iconImageCrossFade, Value<Double>.testConstantValue())
           XCTAssertEqual(layer.iconOpacity, Value<Double>.testConstantValue())
           XCTAssertEqual(layer.iconTranslate, Value<[Double]>.testConstantValue())
           XCTAssertEqual(layer.iconTranslateAnchor, Value<IconTranslateAnchor>.testConstantValue())
           XCTAssertEqual(layer.textColor, Value<StyleColor>.testConstantValue())
           XCTAssertEqual(layer.textEmissiveStrength, Value<Double>.testConstantValue())
           XCTAssertEqual(layer.textHaloBlur, Value<Double>.testConstantValue())
           XCTAssertEqual(layer.textHaloColor, Value<StyleColor>.testConstantValue())
           XCTAssertEqual(layer.textHaloWidth, Value<Double>.testConstantValue())
           XCTAssertEqual(layer.textOpacity, Value<Double>.testConstantValue())
           XCTAssertEqual(layer.textTranslate, Value<[Double]>.testConstantValue())
           XCTAssertEqual(layer.textTranslateAnchor, Value<TextTranslateAnchor>.testConstantValue())
       } catch {
           XCTFail("Failed to decode SymbolLayer")
       }
    }
}

// End of generated file