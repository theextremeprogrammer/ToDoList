import XCTest

struct SimpleXCTestExpectation {
    static func execute(
        testObject: XCTestCase,
        timeout: TimeInterval = 1.0,
        _ closure: (XCTestExpectation) -> Void
    ) {
        let expectation = testObject.expectation(description: "")
        
        closure(expectation)
        
        testObject.waitForExpectations(timeout: timeout, handler: nil)
    }
}
