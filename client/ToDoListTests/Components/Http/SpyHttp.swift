import Foundation
import BrightFutures
@testable import ToDoList

// Often times spies and stubs are combined into a single test double.
class SpyHttp: Http {
    // When spying on arguments passed into functions, as a general practice these vars
    //      are explicitly configured to be "private(set)" to ensure that they cannot
    //      be set outside of this class (for example, accidentally from a test).
    private(set) var get_argument_url: String? = nil
    
    // When stubbing return values these need to be accessible from the test so the
    //      caller can set the value that is expected to be returned.
    var get_returnValue: Future<Data, HttpError> = Future()

    func get(url: String) -> Future<Data, HttpError> {
        // Save the argument(s) that are passed in so the test can make assertions.
        get_argument_url = url
        
        // Return the configured return value that the test expects to be sent back.
        return get_returnValue
    }
    
    
    
    private(set) var post_argument_url: String? = nil
    func post(url: String) {
        post_argument_url = url
    }
}
