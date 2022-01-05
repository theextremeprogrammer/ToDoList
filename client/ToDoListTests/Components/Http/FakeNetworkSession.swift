import PromiseKit
import PMKFoundation

import Foundation
@testable import ToDoList

//class FakeNetworkSession: NetworkSession {
//    var dataTask_completionHandler_inputs: (maybeData: Data?, maybeResponse: URLResponse?, maybeError: Error?) = (nil, nil, nil)
//
//    func dataTask(_: PMKNamespacer, with convertible: URLRequestConvertible) -> Promise<(data: Data, response: URLResponse)> {
////        completionHandler(
////            dataTask_completionHandler_inputs.maybeData,
////            nil,
////            nil
////        )
////
////        // It would be nice to return a URLSessionDataTask here but in doing so a "-resume
////        //      cannot be sent to abstract instance of class NSURLSessionDataTask" error
////        //      message is thrown. Therefore we need to return a SpySessionDataTask here
////        //      to avoid that error.
//        
//        return Promise.pending().resolver.fulfill(Data(), )
//    }
//}
