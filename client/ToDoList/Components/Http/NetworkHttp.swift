import Foundation
import BrightFutures

protocol NetworkSession {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: NetworkSession {}

struct NetworkHttp: Http {
    let networkSession: NetworkSession

    func get(url urlString: String) -> Future<Data, HttpError> {
        // First create a promise so we can return the future from this method call. We
        //      can then call success() or failure() when we receive a response with
        //      the appropriate data or error that is received.
        let requestPromise = Promise<Data, HttpError>()
        
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        
        let _ = networkSession
            .dataTask(with: urlRequest) { (maybeData, maybeUrlResponse, maybeError) in
                if let data = maybeData {
                    requestPromise.success(data)
                }
            }
            .resume()
        
        return requestPromise.future
    }

    func post(url urlString: String, requestBody: String) {
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        
        let _ = networkSession.dataTask(with: urlRequest) { (maybeData, maybeUrlResponse, maybeError) in
        }
    }
}
