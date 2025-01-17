import Foundation

/// A protocol used to provide ``MapInitOptions`` when initializing a ``MapView`` with a Storyboard or
/// a nib.
@objc public protocol MapInitOptionsProvider {
    /// A method to be called when ``MapView`` needs initialization options
    /// - Returns: Initializations options for the ``MapView``.
    func mapInitOptions() -> MapInitOptions
}

/// Options used when initializing `MapView`.
///
/// Contains the `MapOptions` (including `GlyphsRasterizationOptions`)
/// that are required to initialize a `MapView`.
public final class MapInitOptions: NSObject {

    /// Associated `MapOptions`
    public let mapOptions: MapOptions

    /// Style URI for initializing the map. Defaults to Mapbox Streets.
    public let styleURI: StyleURI?

    /// String representation of JSON style spec. Has precedence over ``styleURI``.
    public let styleJSON: String?

    /// Camera options for initializing the map. CameraOptions default to 0.0 for each value.
    public let cameraOptions: CameraOptions?

    /// Creates new instance of ``MapInitOptions``.
    ///
    /// - Parameters:
    ///   - mapOptions: `MapOptions`; see `GlyphsRasterizationOptions` for the default
    ///         used for glyph rendering.
    ///   - cameraOptions: `CameraOptions` to be applied to the map, overriding
    ///         the default camera that has been specified in the style.
    ///   - styleURI: Style URI for the map to load. Defaults to `.streets`, but
    ///         can be `nil`.
    ///   - styleJSON: Style JSON in String representation. Has precedence over ``styleURI``.
    public init(
        mapOptions: MapOptions = MapOptions(),
        cameraOptions: CameraOptions? = nil,
        styleURI: StyleURI? = .standard,
        styleJSON: String? = nil
    ) {
        self.mapOptions      = mapOptions
        self.cameraOptions   = cameraOptions
        self.styleURI        = styleURI
        self.styleJSON       = styleJSON
    }

    /// :nodoc:
    /// See https://developer.apple.com/forums/thread/650054 for context
    @available(*, unavailable)
    internal override init() {
        fatalError("This initializer should not be called.")
    }

    public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? MapInitOptions else {
            return false
        }

        return mapOptions == other.mapOptions &&
            cameraOptions == other.cameraOptions &&
            styleURI == other.styleURI
    }

    public override var hash: Int {
        var hasher = Hasher()
        hasher.combine(mapOptions)
        hasher.combine(cameraOptions)
        hasher.combine(styleURI)
        return hasher.finalize()
    }
}
