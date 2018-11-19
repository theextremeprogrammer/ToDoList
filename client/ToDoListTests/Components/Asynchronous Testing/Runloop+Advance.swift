import Foundation

private let oneHundredthOfASecond: TimeInterval = 0.01

// Generally when using Nimble, the .toEventually() matcher is sufficient for handling
//      waiting for tests to finish. If this is not sufficient, then advancing the
//      runloop can also be used. 
extension RunLoop {
    static func advance(by timeInterval: TimeInterval = oneHundredthOfASecond) {
        let stopDate = Date().addingTimeInterval(timeInterval)
        main.run(until: stopDate)
    }
}
