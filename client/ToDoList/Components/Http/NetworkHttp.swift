import Foundation

protocol Http {
    func get(endpoint: String) -> AsyncReturnValue<Data>
    func post(endpoint: String, requestBody: Data) -> AsyncReturnValue<Data>
}

struct NetworkHttp: Http {
    let baseUrl: String
    let networkSession: NetworkSession
    
    func get(endpoint: String) -> AsyncReturnValue<Data> {
        let urlString = baseUrl + endpoint
        let url = URL(string: urlString)!
        
        return networkSession.dataTask(.promise, with: url)
            .map { (data: Data, response: URLResponse) in
                return data
            }
    }
    
    func post(endpoint: String, requestBody: Data) -> AsyncReturnValue<Data> {
        let urlString = baseUrl + endpoint
        let url = URL(string: urlString)!
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = requestBody
        urlRequest.setValue(
            "application/json; charset=utf-8",
            forHTTPHeaderField: "Content-Type"
        )
        
        return networkSession.dataTask(.promise, with: urlRequest)
            .map { (data: Data, response: URLResponse) in
                return data
            }
    }
}
