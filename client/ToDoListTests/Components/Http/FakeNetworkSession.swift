import Foundation
@testable import ToDoList

class FakeNetworkSession: NetworkSession {
    var dataTask_completionHandler_inputs: (maybeData: Data?, maybeResponse: URLResponse?, maybeError: Error?) = (nil, nil, nil)
    var dataTask_returnValue: SpySessionDataTask? = nil
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    {
        completionHandler(
            dataTask_completionHandler_inputs.maybeData,
            nil,
            nil
        )
        
        // It would be nice to return a URLSessionDataTask here but in doing so a "-resume cannot be sent to abstract instance of class NSURLSessionDataTask" error message is thrown. Therefore we need to return a SpySessionDataTask here to avoid that error.
        return dataTask_returnValue ?? SpySessionDataTask()
    }
}
