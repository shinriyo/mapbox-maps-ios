import XCTest
import Foundation
import MapboxMaps

@MainActor
class SpecsBenchmark: XCTestCase {
    func testBaselineMeasure() throws {
        let scenario = Scenario(name: "manual", commands: [
        ])

        // Assign actual number of repeats
        // to support changes over Xcode versions
        try measureScenario(scenario)
    }

    func testNavDayMunichTtrcCold() throws {
        try runScenarioBenchmark(name: "nav-day-munich-ttrc-cold")
    }

    func testNavDayMunichTtrcWarm() throws {
        try runScenarioBenchmark(name: "nav-day-munich-ttrc-warm")
    }

    func testStreetsMunichTtrcCold() throws {
        try runScenarioBenchmark(name: "streets-munich-ttrc-cold")
    }

    func testStreetsMunichTtrcWarm() throws {
        try runScenarioBenchmark(name: "streets-munich-ttrc-warm")
    }

    func testNavDayMunichZoom() throws {
        try runScenarioBenchmark(name: "nav-day-munich-zoom", extraMetrics: [FPSMetric(testCase: self)], timeout: 120)
    }

    func testNavDayMunichZoomTilepack() throws {
        try runScenarioBenchmark(name: "nav-day-munich-zoom-tilepack", timeout: 120)
    }

    func testNavDayMunichDriveTilePack() throws {
        try runScenarioBenchmark(name: "nav-day-munich-drive-tilepack",
                                 shouldSkipWarmupRun: true,
                                 iterationCount: 1,
                                 extraMetrics: [FPSMetric(testCase: self)],
                                 timeout: 1800)
    }
}

extension SpecsBenchmark {
    func runScenarioBenchmark(name: String,
                              shouldSkipWarmupRun: Bool = false,
                              iterationCount: Int? = nil,
                              extraMetrics: [XCTMetric] = [],
                              timeout: TimeInterval = 60,
                              functionName: String = #function) throws {
        let url = try XCTUnwrap(Bundle.main.url(forResource: name, withExtension: "json"))
        let scenario = try Scenario(filePath: url)

        try measureScenario(scenario,
                            shouldSkipWarmupRun: shouldSkipWarmupRun,
                            iterationCount: iterationCount,
                            extraMetrics: extraMetrics,
                            timeout: timeout,
                            functionName: functionName)
    }

    func measureScenario(_ scenario: Scenario,
                         shouldSkipWarmupRun: Bool = false,
                         iterationCount: Int? = nil,
                         extraMetrics: [XCTMetric] = [],
                         timeout: TimeInterval = 60,
                         functionName: String = #function) throws {
        let metrics = extraMetrics + [
            XCTCPUMetric(),
            XCTMemoryMetric(),
            XCTStorageMetric(),
            XCTClockMetric(),
            ThermalStateMetric()
        ]

        let options = XCTMeasureOptions()
        options.invocationOptions = [.manuallyStop]

        if let iterationCount = iterationCount {
            options.iterationCount = iterationCount
        }

        scenario.onMapCreate = metrics.compactMap({ $0 as? FPSMetric }).first?.attach(mapView:)

        var runIndex = 0
        measure(metrics: metrics, options: options) {
            defer { runIndex += 1 }
            if shouldSkipWarmupRun && runIndex == 0 { return self.stopMeasuring() }

            let scenarioExpectation = expectation(description: "Scenario '\(name)' finished")
            Task {
                try await scenario.run()
                scenarioExpectation.fulfill()
                self.stopMeasuring()
            }

            waitForExpectations(timeout: timeout) { error in
                XCTAssertNil(error)
            }
        }
    }
}