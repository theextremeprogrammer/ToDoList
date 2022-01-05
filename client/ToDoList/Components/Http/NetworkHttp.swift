import Foundation

protocol NetworkSession {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: NetworkSession {}

enum HttpError: Error {}

protocol Http {
    func get(endpoint: String) -> AsyncReturnValue<Data, HttpError>
    func post(endpoint: String, requestBody: Data) -> AsyncReturnValue<Data, HttpError>
}

struct NetworkHttp: Http {
    let baseUrl: String
    let networkSession: NetworkSession

    func get(endpoint: String) -> AsyncReturnValue<Data, HttpError> {
        // First create a promise so we can return the future from this method call. We
        //      can then call success() or failure() when we receive a response with
        //      the appropriate data or error that is received.
        let requestPromise = AsyncPromise<Data, HttpError>()
        
        let urlString = baseUrl + endpoint
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

    func post(endpoint: String, requestBody: Data) -> AsyncReturnValue<Data, HttpError> {
        let requestPromise = AsyncPromise<Data, HttpError>()
        
        let urlString = baseUrl + endpoint
        let url = URL(string: urlString)!
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = requestBody
        
        urlRequest.setValue(
            "application/json; charset=utf-8",
            forHTTPHeaderField: "Content-Type"
        )
        
        let _ = networkSession
            .dataTask(with: urlRequest) { (maybeData, maybeUrlResponse, maybeError) in
                if let data = maybeData {
                    requestPromise.success(data)
                }
            }
            .resume()
        
        return requestPromise.future
    }
}
