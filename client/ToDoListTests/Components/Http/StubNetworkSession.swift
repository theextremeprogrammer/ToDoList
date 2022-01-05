// TODO: How to not include these here?
import PromiseKit
import PMKFoundation

import Foundation
@testable import ToDoList
import XCTest

class StubNetworkSession: NetworkSession {
    var dataTask_completionPromise_inputs: (data: Data, response: URLResponse)? = nil

    func dataTask(_: PMKNamespacer, with convertible: URLRequestConvertible) -> Promise<(data: Data, response: URLResponse)> {
        
        guard let dataTask_completionPromise_inputs = dataTask_completionPromise_inputs else {
            XCTFail()
            return AsyncReturnValue.pending().promise
        }
        
        return AsyncReturnValue.value(dataTask_completionPromise_inputs)
    }
}
