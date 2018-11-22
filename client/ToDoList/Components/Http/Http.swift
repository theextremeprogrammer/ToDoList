import Foundation
import BrightFutures

protocol Http {
    func get(url: String) -> Future<Data, HttpError>
    func post(url: String, requestBody: String)
}

enum HttpError: Error {}
