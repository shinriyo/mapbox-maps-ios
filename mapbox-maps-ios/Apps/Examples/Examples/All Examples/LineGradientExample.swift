import UIKit
import MapboxMaps

public class LineGradientExample: UIViewController, ExampleProtocol {

    internal var mapView: MapView!
    internal var lastTrimOffset = 0.0
    let button = UIButton(type: .system)
    private var cancelables = Set<AnyCancelable>()

    override public func viewDidLoad() {
        super.viewDidLoad()

        let options = MapInitOptions(styleURI: .light)
        mapView = MapView(frame: view.bounds, mapInitOptions: options)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)

        mapView.mapboxMap.onMapLoaded.observeNext { _ in
            self.setupExample()

            // Set the center coordinate and zoom level.
            let centerCoordinate = CLLocationCoordinate2D(latitude: 38.875, longitude: -77.035)
            let camera = CameraOptions(center: centerCoordinate, zoom: 12.0)
            self.mapView.mapboxMap.setCamera(to: camera)
        }.store(in: &cancelables)

        button.setTitle("Increase trim offset", for: .normal)
        button.backgroundColor = .white
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([button.centerXAnchor.constraint(equalTo: view.centerXAnchor), button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
        button.addTarget(self, action: #selector(increaseTrimOffset), for: .touchUpInside)
    }

    @objc func increaseTrimOffset() {
        lastTrimOffset += 0.05
        let trimOffset = Double.minimum(lastTrimOffset, 1.0)
        try? mapView.mapboxMap.setLayerProperty(for: "line-layer", property: "line-trim-offset", value: [0.0, trimOffset])
    }

    // Load GeoJSON file from local bundle and decode into a `FeatureCollection`.
    internal func decodeGeoJSON(from fileName: String) throws -> FeatureCollection? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "geojson") else {
            preconditionFailure("File '\(fileName)' not found.")
        }
        let filePath = URL(fileURLWithPath: path)
        var featureCollection: FeatureCollection?
        do {
            let data = try Data(contentsOf: filePath)
            featureCollection = try JSONDecoder().decode(FeatureCollection.self, from: data)
        } catch {
            print("Error parsing data: \(error)")
        }
        return featureCollection
    }

    internal func setupExample() {
        // The below lines are used for internal testing purposes only.
        DispatchQueue.main.asyncAfter(deadline: .now()+5.0) {
            self.finish()
        }

        // Attempt to decode GeoJSON from file bundled with application.
        guard let featureCollection = try? decodeGeoJSON(from: "GradientLine") else { return }

        // Create a GeoJSON data source.
        var geoJSONSource = GeoJSONSource(id: "geoJSON-data-source")
        geoJSONSource.data = .featureCollection(featureCollection)
        geoJSONSource.lineMetrics = true // MUST be `true` in order to use `lineGradient` expression

        // Create a line layer
        var lineLayer = LineLayer(id: "line-layer", source: geoJSONSource.id)
        lineLayer.filter = Exp(.eq) {
            "$type"
            "LineString"
        }

        // Styling the line
        lineLayer.lineColor = .constant(StyleColor(.red))
        lineLayer.lineGradient = .expression(
            Exp(.interpolate) {
                Exp(.linear)
                Exp(.lineProgress)
                0
                UIColor.blue
                0.1
                UIColor.purple
                0.3
                UIColor.cyan
                0.5
                UIColor.green
                0.7
                UIColor.yellow
                1
                UIColor.red
            }
        )

        let lowZoomWidth = 10
        let highZoomWidth = 20
        lineLayer.lineWidth = .expression(
            Exp(.interpolate) {
                Exp(.linear)
                Exp(.zoom)
                14
                lowZoomWidth
                18
                highZoomWidth
            }
        )
        lineLayer.lineCap = .constant(.round)
        lineLayer.lineJoin = .constant(.round)

        // Add the source and style layer to the map style.
        try! mapView.mapboxMap.addSource(geoJSONSource)
        try! mapView.mapboxMap.addLayer(lineLayer, layerPosition: nil)
    }
}