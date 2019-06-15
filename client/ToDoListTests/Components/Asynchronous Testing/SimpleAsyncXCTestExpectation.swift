import Quick

struct AsyncExpectation {
    /// The purpose of this method is to make it easier to write asynchronous tests by managing the boilerplate code needed by creating an XCTestExpectation and waiting for it to complete while the caller can fulfill that expectation once the asynchronous code has finished executing.
    ///
    /// - Parameters:
    ///   - description: Description for the expection
    ///   - timeout: Desired timeout value in seconds
    ///   - file: Original file from which this method was called
    ///   - line: Line from the original file from which this method was called
    ///   - closure: Statements which will execute asynchronously
    ///
    /// - Note: Remember to call `expectation.fulfill()` from the closure to indicate when the asynchronous code has completed executing.
    ///
    static func execute(
        description: String = "",
        timeout: TimeInterval = 1.0,
        file: StaticString = #file,
        line: UInt = #line,
        _ closure: (XCTestExpectation) -> Void
    ) {
        let testExpectation = QuickSpec.current.expectation(description: description)

        closure(testExpectation)

        QuickSpec
            .current
            .waitForExpectations(timeout: timeout, handler: { maybeError in
                guard let _ = maybeError else {
                    return
                }

                XCTFail("Async operation timed out.", file: file, line: line)
            })
    }
}
