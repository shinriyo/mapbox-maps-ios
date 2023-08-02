@testable import MapboxMaps
@_implementationOnly import MapboxCoreMaps_Private

final class MockDelegatingMapClientDelegate: DelegatingMapClientDelegate {
    let scheduleRepaintStub = Stub<Void, Void>()
    func scheduleRepaint() {
        scheduleRepaintStub.call()
    }

    let getMetalViewStub = Stub<MTLDevice?, MTKView?>(defaultReturnValue: nil)
    func getMetalView(for metalDevice: MTLDevice?) -> MTKView? {
        return getMetalViewStub.call(with: metalDevice)
    }
}