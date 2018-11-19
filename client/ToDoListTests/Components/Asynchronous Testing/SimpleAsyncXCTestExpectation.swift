import XCTest

struct SimpleXCTestExpectation {
    // The purpose of this method is to make it easier to write asynchronous tests by
    //      managing the boilerplate code needed by creating an XCTestExpectation and
    //      waiting for it to complete while the caller can fulfill that expectation
    //      once the asynchronous code has finished executing.
    static func execute(
        testCase: XCTestCase,
        timeout: TimeInterval = 1.0,
        _ closure: (XCTestExpectation) -> Void
    ) {
        let testExpectation = testCase.expectation(description: "")
        
        closure(testExpectation)
        
        testCase.waitForExpectations(timeout: timeout, handler: nil)
    }
}
