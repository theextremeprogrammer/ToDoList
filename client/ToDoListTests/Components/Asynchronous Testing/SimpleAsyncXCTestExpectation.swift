import XCTest

struct SimpleXCTestExpectation {
    static func execute(
        testCase: XCTestCase,
        timeout: TimeInterval = 1.0,
        _ closure: (XCTestExpectation) -> Void
    ) {
        let expectation = testCase.expectation(description: "")
        
        closure(expectation)
        
        testCase.waitForExpectations(timeout: timeout, handler: nil)
    }
}
