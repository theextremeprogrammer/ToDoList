// TODO: How to not include these here?
import PromiseKit
import PMKFoundation

import Foundation
@testable import ToDoList

class SpyNetworkSession: NetworkSession {
    private(set) var dataTask_argument_request: URLRequest? = nil

    func dataTask(_: PMKNamespacer, with convertible: URLRequestConvertible) -> Promise<(data: Data, response: URLResponse)> {
        dataTask_argument_request = convertible.pmkRequest
        return AsyncReturnValue.pending().promise
    }
}
