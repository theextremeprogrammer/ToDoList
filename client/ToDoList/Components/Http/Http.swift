import Foundation
import BrightFutures

protocol Http {
    func get(endpoint: String) -> Future<Data, HttpError>
    func post(endpoint: String, requestBody: Data) -> Future<Data, HttpError>
}

enum HttpError: Error {}
