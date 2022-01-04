import Foundation
@testable import ToDoList

// Often times spies and stubs are combined into a single test double.
class SpyHttp: Http {
    // When spying on arguments passed into functions, as a general practice these vars
    //      are explicitly configured to be "private(set)" to ensure that they cannot
    //      be set outside of this class (for example, accidentally from a test).
    //
    // The format used for the names of these variables is:
    //      <methodname>_argument_<variablename>
    private(set) var get_argument_endpoint: String? = nil

    // When stubbing return values for asynchronous code we can simplify the boilerplate
    //      code by always creating a Promise and then returning the future which is
    //      associated with it.
    //
    // This means that when the method is called from a test it won't throw an error
    //      and instead it becomes possible to instruct the Promise to succeed or fail
    //      according to the desired test behavior.
    //
    // Since this Promise is initialized within the test double itself there's no need
    //      to allow this to be set outside of this object, therefore the scope for this
    //      can be defined as private(set).
    //
    // The format used for the names of these variables is:
    //      <methodname>_returnPromise
//    private(set) var get_returnPromise = Promise<Data, HttpError>()

    func get(endpoint: String) async throws -> Data {
//    func get(endpoint: String) -> Future<Data, HttpError> {
//        // Save the argument(s) that are passed in so the test can make assertions.
//        get_argument_endpoint = endpoint
//
//        // Return the future asspociated to the promise. This way we can configure
//        //      the promise to succeed or fail according to what we are testing.
//        return get_returnPromise.future
        return Data()
    }

    
    
    private(set) var post_argument_endpoint: String? = nil
    private(set) var post_argument_requestBody: Data? = nil
//    private(set) var post_returnPromise = Promise<Data, HttpError>()
    func post(endpoint: String, requestBody: Data) async throws -> Data {
//        post_argument_endpoint = endpoint
//        post_argument_requestBody = requestBody
//
//        return post_returnPromise.future
        return Data()
    }
}
