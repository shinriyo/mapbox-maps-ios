import Foundation

internal protocol DelegatingDisplayLinkParticipantDelegate: AnyObject {
    func participate(for participant: DelegatingDisplayLinkParticipant)
}

final internal class DelegatingDisplayLinkParticipant: DisplayLinkParticipant {

    weak var delegate: DelegatingDisplayLinkParticipantDelegate?

    func participate() {
        delegate?.participate(for: self)
    }
}
