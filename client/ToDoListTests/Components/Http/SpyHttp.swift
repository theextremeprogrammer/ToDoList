import Foundation
import BrightFutures
@testable import ToDoList

class SpyHttp: Http {
    private(set) var get_argument_url: String? = nil
    var get_returnValue: Future<Data, HttpError> = Future()
    func get(url: String) -> Future<Data, HttpError> {
        get_argument_url = url
        
        return get_returnValue
    }
}
