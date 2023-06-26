/// Signal is a typed interface for observing arbitrary values over time.
///
/// Signal delegates observers managing logic to the `observeImpl` closure, but provides flexible interface for observing.
///
/// - Note: `Signal` is iOS12-compatible simplified alternative to `Combine.Publisher`. It's behavior is
/// aligned with Publisher for easier future migration to Combine. If your app supports iOS >= 13.0, use `Signal` as `Combine.Publisher` .
public struct Signal<Payload> {
    /// Handles received payloads.
    public typealias Handler = (Payload) -> Void

    /// A closure that implements observing.
    public typealias ObserveImpl = (@escaping Handler) -> AnyCancelable

    private let observeImpl: ObserveImpl

    /// Adds an observer closure that will be called every time signal is triggered.
    ///
    /// - Note: Analogous to `sink` in Combine.
    ///
    /// - Parameters:
    ///     - handler: A handler closure.
    /// - Returns: Cancellable object that is used to cancel the subscription. If it is canceled or deinited the subscription will be cancelled immediately.
    public func observe(_ handler: @escaping Handler) -> AnyCancelable {
        self.observeImpl(handler)
    }

    /// Creates a signal.
    ///
    /// - Parameters:
    ///     - observeImpl: A closure that implements observing.
    public init(observeImpl: @escaping ObserveImpl) {
        self.observeImpl = observeImpl
    }
}

extension Signal {
    /// Adds an observer closure that will be triggered only once.
    ///
    /// - Note: Analogous to `prefix(1).sink` in Combine.
    ///
    /// - Parameters:
    ///     - handler: A handler closure.
    /// - Returns: Cancellable object that is used to cancel the subscription. If it is canceled or deinited the subscription will be cancelled immediately.
    public func observeNext(_ handler: @escaping Handler) -> AnyCancelable {
        takeFirst().observe(handler)
    }
}

// NOTE: Signal implements the Combine.Publisher, which means every operator available for
// Publisher (such as `map`, `prefix`, `sink` and others) may be used on Signal.
// It means that Signal's naming shouldn't collide with Combine for better user experience.
// We don't ship full-featured reactive framework (which Combine is) with Maps SDK,
// so be careful with publishing operators on Signal.
// Currently only the `observe` and `observeNext` are published which seem to be enough
// for the most common use cases.
extension Signal {
    /// Creates a signal that triggers once, then cancels itself.
    internal func takeFirst() -> Signal {
        return Signal { handler in
            weak var weakToken: AnyCancelable?
            let token = self.observe { payload in
                weakToken?.cancel()
                handler(payload)
            }
            weakToken = token
            return token
        }
    }

    /// Creates a signal that triggers if `condition` is `true`.
    internal func filter(_ condition: @escaping (Payload) -> Bool) -> Signal {
        Signal(observeImpl: { handle in
            observeImpl { payload in
                if condition(payload) {
                    handle(payload)
                }
            }
        })
    }

    /// Creates a signal that is enabled only when `isEnabled` value is `true`.
    internal func conditional(_ isEnabled: Ref<Bool>) -> Signal {
        filter { _ in isEnabled.value }
    }

    /// Creates  a Signal that joins values and errors signals into a resulting signal.
    internal func join<E>(withError other: Signal<E>) -> Signal<Result<Payload, E>> {
        return Signal<Result<Payload, E>> { handler in
            AnyCancelable([
                self.observe { payload in
                    handler(.success(payload))
                },
                other.observe { e in
                    handler(.failure(e))
                }
            ])
        }
    }
}