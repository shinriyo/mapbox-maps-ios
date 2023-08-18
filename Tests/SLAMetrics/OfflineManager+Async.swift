import Foundation
import MapboxMaps

extension OfflineManager {
    @MainActor
    func allStylePacks() async throws -> [StylePack] {
        return try await withCheckedThrowingContinuation { continuation in
            allStylePacks { stylePacks in
                continuation.resume(with: stylePacks)
            }
        }
    }

    @MainActor
    @discardableResult
    func loadStylePack(for styleURI: StyleURI,
                       loadOptions: StylePackLoadOptions,
                       progress: StylePackLoadProgressCallback? = nil) async throws -> StylePack {

        return try await withCheckedThrowingContinuation { continuation in
            loadStylePack(for: styleURI, loadOptions: loadOptions, progress: progress) { result in
                continuation.resume(with: result)
            }
        }
    }

    @MainActor
    @discardableResult
    func remove(stylePack: StylePack) async throws -> StylePack {
        try await withCheckedThrowingContinuation { continuation in
            removeStylePack(for: StyleURI(rawValue: stylePack.styleURI)!, completion: continuation.resume(with:))
        }
    }
}