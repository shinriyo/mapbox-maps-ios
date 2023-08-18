import Foundation
import MapboxCoreMaps
@_spi(Experimental) import MapboxMaps

struct SetMemoryBudgetCommand: AsyncCommand, Decodable {
    private enum BudgetType: Decodable {
        case megabytes(UInt64)
        case tiles(UInt64)

        init(from decoder: Decoder) throws {
            enum DecodingKeys: String, CodingKey {
                case megabytes, tiles
            }

            let container = try decoder.container(keyedBy: DecodingKeys.self)
            guard container.allKeys.count == 1 else {
                let errorContext = DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Expect only one key but found \(container.allKeys.count)"
                )
                throw DecodingError.dataCorrupted(errorContext)
            }

            switch container.allKeys[0] {
            case .megabytes:
                self = .megabytes(try container.decode(UInt64.self, forKey: .megabytes))
            case .tiles:
                self = .tiles(try container.decode(UInt64.self, forKey: .tiles))
            }
        }
    }

    private let budget: BudgetType

    init(from decoder: Decoder) throws {
        budget = try BudgetType(from: decoder)
    }

    @MainActor
    func execute(context: Context) async throws {
        guard let mapView = context.mapView else {
            throw ExecutionError.cannotFindMapboxMap
        }

        let memoryBudget: TileCacheBudget
        switch budget {
        case .megabytes(let megabytes):
            memoryBudget = .fromTileCacheBudget(TileCacheBudgetInMegabytes(size: megabytes))
        case .tiles(let tiles):
            memoryBudget = .fromTileCacheBudget(TileCacheBudgetInTiles(size: tiles))
        }

        mapView.mapboxMap.setTileCacheBudget(memoryBudget)
    }
}