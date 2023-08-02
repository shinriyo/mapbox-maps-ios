import UIKit
@_spi(Experimental) import MapboxMaps

internal class StandardStyleExample: UIViewController, ExampleProtocol {

    private var mapView: MapView!
    private var cancelables = Set<AnyCancelable>()

    private enum LightPresets: String {
        case day
        case dawn
        case dusk
        case night
    }

    private var lightSetting = LightPresets.day
    private var labelsSetting = true

    // Load a style which imports Mapbox Standard as a basemap
    let styleURL = Bundle.main.url(forResource: "fragment-realestate-NY", withExtension: "json")!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the camera options to center on New York City
        let options = MapInitOptions(cameraOptions: CameraOptions(center: CLLocationCoordinate2D(latitude: 40.72, longitude: -73.99), zoom: 11, pitch: 45), styleURI: StyleURI(url: styleURL))
        mapView = MapView(frame: view.bounds, mapInitOptions: options)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)

        // When the style has finished loading add a line layer representing the border between New York and New Jersey
        mapView.mapboxMap.onStyleLoaded.observe { [weak self] _ in

            // Create and apply basic styling to the fill layer, assign the layer to the "middle" slot
            var layer = LineLayer(id: "line-layer", source: "line-layer")
            layer.lineColor = .constant(StyleColor.init(UIColor.orange))
            layer.lineWidth = .constant(8)
            layer.slot = "middle"

            // Create a new GeoJSON data source of the line's coordinates
            var source = GeoJSONSource(id: "line-layer")
            source.data = .geometry(.lineString(LineString([
                CLLocationCoordinate2D(latitude: 40.913503418907936, longitude: -73.91912400100642),
                CLLocationCoordinate2D(latitude: 40.82943110786286, longitude: -73.9615887363045),
                CLLocationCoordinate2D(latitude: 40.75461056309348, longitude: -74.01409059085539),
                CLLocationCoordinate2D(latitude: 40.69522028220487, longitude: -74.02798814058939),
                CLLocationCoordinate2D(latitude: 40.65188756398558, longitude: -74.05655532615407),
                CLLocationCoordinate2D(latitude: 40.64339339389301, longitude: -74.13916853846217),
            ])))

            do {
                try self?.mapView.mapboxMap.addSource(source)
                try self?.mapView.mapboxMap.addLayer(layer)
            } catch {
                print(error)
            }

            // The below line is used for internal testing purposes only.
            self?.finish()
        }.store(in: &cancelables)

        // Add buttons to control the light presets and labels
        let lightButton = changeLightButton()
        let labelsButton = changeLabelsButton()
        navigationItem.rightBarButtonItems = [lightButton, labelsButton]
    }

    private func changeLightButton() -> UIBarButtonItem {
        if #available(iOS 13, *) {
            return UIBarButtonItem(image: UIImage(systemName: "sun.max.fill"), style: .plain, target: self, action: #selector(changeLightSetting))
        } else {
            return UIBarButtonItem(title: "Sun", style: .plain, target: self, action: #selector(changeLightSetting))
        }
    }

    private func changeLabelsButton() -> UIBarButtonItem {
        if #available(iOS 13, *) {
            return UIBarButtonItem(image: UIImage(systemName: "signpost.right"), style: .plain, target: self, action: #selector(changeLabelsSetting))
        } else {
            return UIBarButtonItem(title: "star", style: .plain, target: self, action: #selector(changeLabelsSetting))
        }
    }

    @objc private func changeLightSetting() {
        switch lightSetting {
        case .day:
            lightSetting = .dawn
        case .dawn:
            lightSetting = .dusk
        case .dusk:
            lightSetting = .night
        case .night:
            lightSetting = .day
        }

        // When a user clicks the light setting button change the `lightPreset` config property on the Standard style import
        do {
            try self.mapView.mapboxMap.setStyleImportConfigProperty(for: "standard", config: "lightPreset", value: lightSetting.rawValue)
        } catch {
            print(error)
        }
    }

    @objc private func changeLabelsSetting() {
        labelsSetting.toggle()

        // When a user clicks the labels setting button change the label config properties on the Standard style import to show/hide them
        do {
            try self.mapView.mapboxMap.setStyleImportConfigProperty(for: "standard", config: "showPlaceLabels", value: labelsSetting)
            try self.mapView.mapboxMap.setStyleImportConfigProperty(for: "standard", config: "showRoadLabels", value: labelsSetting)
            try self.mapView.mapboxMap.setStyleImportConfigProperty(for: "standard", config: "showPointInterestLabels", value: labelsSetting)
            try self.mapView.mapboxMap.setStyleImportConfigProperty(for: "standard", config: "showTransitLabels", value: labelsSetting)
        } catch {
            print(error)
        }
    }
}