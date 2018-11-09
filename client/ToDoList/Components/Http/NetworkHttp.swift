import Foundation
import BrightFutures

protocol NetworkSession {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

struct NetworkHttp: Http {
    let networkSession: NetworkSession

    func get(url urlString: String) -> Future<Data, HttpError>? {
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        let _ = networkSession.dataTask(with: urlRequest) { (maybeData, maybeUrlResponse, maybeError) in
            // TODO: Implementation
        }
        
        return nil
    }
}
