import Foundation

// This object exists to confirm that we are calling the resume() method on the
//      URLSessionDataTask to ensure that the data task is initiated.
class SpySessionDataTask: URLSessionDataTask {
    private(set) var resume_wasCalled: Bool = false
    override func resume() {
        resume_wasCalled = true
    }
}
