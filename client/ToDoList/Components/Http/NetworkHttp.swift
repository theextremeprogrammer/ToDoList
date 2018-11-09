import Foundation

protocol NetworkSession {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

struct NetworkHttp: Http {
    let networkSession: NetworkSession

    func get(url: String) {
        // TODO: Implementation
    }
}
