import Foundation
import PromiseKit
import PMKFoundation

protocol NetworkSession {
    func dataTask(
        _: PMKNamespacer,
        with convertible: URLRequestConvertible
    ) -> Promise<(data: Data, response: URLResponse)>
}

extension URLSession: NetworkSession {}
