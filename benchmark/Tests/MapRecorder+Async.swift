@testable import MapboxMaps

extension MapRecorder {
    func replay(content: String, playbackCount: Int = 1, playbackSpeedMultiplier: Double = 1.0) async {
        return await withCheckedContinuation { continuation in
            replay(content: content, playbackCount: playbackCount, playbackSpeedMultiplier: playbackSpeedMultiplier) {
                continuation.resume(returning: ())
            }
        }
    }
}
