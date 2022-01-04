import Foundation

protocol NetworkSession {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: NetworkSession {}

struct NetworkHttp: Http {
    let baseUrl: String
    let networkSession: NetworkSession

    func get(endpoint: String) async throws -> Data {
        let urlString = baseUrl + endpoint
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)

        // Since there is no "async/await" version of networkSession.dataTask(with:), the special
        //      `await withCheckedContinuation` contstruct must be used to work with async/await.
        return await withCheckedContinuation { continuation in
            let _ = networkSession
                .dataTask(with: urlRequest) { (maybeData, maybeUrlResponse, maybeError) in
                    if let data = maybeData {
                        continuation.resume(with: Result.success(data))
                    }
                }
                .resume()
        }
    }

    func post(endpoint: String, requestBody: Data) async throws -> Data {
        let urlString = baseUrl + endpoint
        let url = URL(string: urlString)!
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = requestBody
        urlRequest.setValue(
            "application/json; charset=utf-8",
            forHTTPHeaderField: "Content-Type"
        )

        return await withCheckedContinuation { continuation in
            networkSession
                .dataTask(with: urlRequest) { (maybeData, maybeUrlResponse, maybeError) in
                    if let data = maybeData {
                        continuation.resume(with: Result.success(data))
                    }
                }
                .resume()
        }
    }
}
