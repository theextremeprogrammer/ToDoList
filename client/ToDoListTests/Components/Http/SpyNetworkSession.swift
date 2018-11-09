import Foundation
@testable import ToDoList

class SpyNetworkSession: NetworkSession {
    private(set) var dataTask_argument_request: URLRequest? = nil
    
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    {
        dataTask_argument_request = request
        return URLSessionDataTask()
    }
}
