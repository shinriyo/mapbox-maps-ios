// This file is generated
import XCTest
@_spi(Experimental) @testable import MapboxMaps

final class BackgroundLayerTests: XCTestCase {

    func testLayerProtocolMembers() {

        var layer = BackgroundLayer(id: "test-id")
        layer.minZoom = 10.0
        layer.maxZoom = 20.0

        XCTAssertEqual(layer.id, "test-id")
        XCTAssertEqual(layer.type, LayerType.background)
        XCTAssertEqual(layer.minZoom, 10.0)
        XCTAssertEqual(layer.maxZoom, 20.0)
    }

    func testEncodingAndDecodingOfLayerProtocolProperties() {
        var layer = BackgroundLayer(id: "test-id")
        layer.minZoom = 10.0
        layer.maxZoom = 20.0

        var data: Data?
        do {
            data = try JSONEncoder().encode(layer)
        } catch {
            XCTFail("Failed to encode BackgroundLayer")
        }

        guard let validData = data else {
            XCTFail("Failed to encode BackgroundLayer")
            return
        }

        do {
            let decodedLayer = try JSONDecoder().decode(BackgroundLayer.self, from: validData)
            XCTAssertEqual(decodedLayer.id, "test-id")
            XCTAssertEqual(decodedLayer.type, LayerType.background)
            XCTAssertEqual(decodedLayer.minZoom, 10.0)
            XCTAssertEqual(decodedLayer.maxZoom, 20.0)
        } catch {
            XCTFail("Failed to decode BackgroundLayer")
        }
    }

    func testEncodingAndDecodingOfLayoutProperties() {
        var layer = BackgroundLayer(id: "test-id")
        layer.visibility = .constant(.visible)

        var data: Data?
        do {
            data = try JSONEncoder().encode(layer)
        } catch {
            XCTFail("Failed to encode BackgroundLayer")
        }

        guard let validData = data else {
            XCTFail("Failed to encode BackgroundLayer")
            return
        }

        do {
            let decodedLayer = try JSONDecoder().decode(BackgroundLayer.self, from: validData)
            XCTAssert(decodedLayer.visibility == .constant(.visible))
        } catch {
            XCTFail("Failed to decode BackgroundLayer")
        }
    }

    func testEncodingAndDecodingOfPaintProperties() {
       var layer = BackgroundLayer(id: "test-id")
       layer.backgroundColor = Value<StyleColor>.testConstantValue()
       layer.backgroundColorTransition = StyleTransition(duration: 10.0, delay: 10.0)
       layer.backgroundEmissiveStrength = Value<Double>.testConstantValue()
       layer.backgroundEmissiveStrengthTransition = StyleTransition(duration: 10.0, delay: 10.0)
       layer.backgroundOpacity = Value<Double>.testConstantValue()
       layer.backgroundOpacityTransition = StyleTransition(duration: 10.0, delay: 10.0)
       layer.backgroundPattern = Value<ResolvedImage>.testConstantValue()

       var data: Data?
       do {
           data = try JSONEncoder().encode(layer)
       } catch {
           XCTFail("Failed to encode BackgroundLayer")
       }

       guard let validData = data else {
           XCTFail("Failed to encode BackgroundLayer")
           return
       }

       do {
           let decodedLayer = try JSONDecoder().decode(BackgroundLayer.self, from: validData)
           XCTAssert(decodedLayer.visibility == .constant(.visible))
           XCTAssertEqual(layer.backgroundColor, Value<StyleColor>.testConstantValue())
           XCTAssertEqual(layer.backgroundEmissiveStrength, Value<Double>.testConstantValue())
           XCTAssertEqual(layer.backgroundOpacity, Value<Double>.testConstantValue())
           XCTAssertEqual(layer.backgroundPattern, Value<ResolvedImage>.testConstantValue())
       } catch {
           XCTFail("Failed to decode BackgroundLayer")
       }
    }
}

// End of generated file