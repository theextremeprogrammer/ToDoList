import Foundation
@testable import ToDoList

class SpyNetworkSession: NetworkSession {
    private(set) var dataTask_argument_request: URLRequest? = nil
    
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    {
        dataTask_argument_request = request
        
        // If the completion handler is not called from here, this results in a "SWIFT TASK CONTINUATION MISUSE:
        //      get(endpoint:) leaked its continuation!" because `continuation.resume()` is never called. This is
        //      unfortunate for this spy test double to have to do this. 
        completionHandler(Data(), nil, nil)
        
        return SpySessionDataTask()
    }
}
