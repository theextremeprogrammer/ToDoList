import Foundation

protocol Http {
    func get(endpoint: String) async throws -> Data
    func post(endpoint: String, requestBody: Data) async throws -> Data
}

enum HttpError: Error {}
