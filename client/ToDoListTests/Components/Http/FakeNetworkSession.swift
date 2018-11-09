import Foundation
@testable import ToDoList

class FakeNetworkSession: NetworkSession {
    var dataTask_completionHandler_inputs: (maybeData: Data?, maybeResponse: URLResponse?, maybeError: Error?) = (nil, nil, nil)
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    {
        completionHandler(
            dataTask_completionHandler_inputs.maybeData,
            nil,
            nil
        )
        
        return URLSessionDataTask()
    }
}
