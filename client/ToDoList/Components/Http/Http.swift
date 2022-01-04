import Foundation

protocol Http {
    func get(endpoint: String) async throws -> Data
    //func post(endpoint: String, requestBody: Data) -> Future<Data, HttpError>
}

enum HttpError: Error {}
