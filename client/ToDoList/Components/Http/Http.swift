import Foundation
import BrightFutures

protocol Http {
    func get(url: String) -> Future<Data, HttpError>?
}

enum HttpError: Error {}
