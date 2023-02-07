@testable import TestsSupport
import MapboxMaps

extension ViewportStatus {
    static func random() -> Self {
        return [
            .idle,
            .state(MockViewportState()),
            .transition(MockViewportTransition(), toState: MockViewportState())
        ].randomElement()!
    }
}
