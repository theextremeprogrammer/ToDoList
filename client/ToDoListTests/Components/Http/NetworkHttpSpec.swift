import Quick
import Nimble
import Foundation
@testable import ToDoList
import XCTest

class NetworkHttpSpec: QuickSpec {
    override func spec() {
        describe("http get requests") {
            it("makes a request to the correct endpoint") {
                // Sadly, Quick does not yet support async/await the same as XCTest does, so each test needs to be
                //      wrapped in a Task to execute properly: https://github.com/Quick/Quick/issues/1084
                Task {
                    // This test uses the SpyNetworkSession since we are only spying on the data sent to it.
                    let spyNetworkSession = SpyNetworkSession()
                    let networkHttp = NetworkHttp(
                        baseUrl: "http://www.example.com",
                        networkSession: spyNetworkSession
                    )
                
                
                    do {
                        let _ = try await networkHttp.get(endpoint: "/endpoint")
                    }


                    let actualUrlString = spyNetworkSession.dataTask_argument_request?.url?.absoluteString
                    // Nimble matchers also do not support async/await and throw an error
                    //      when not called on the main thread
                    //expect(actualUrlString).to(equal("http://www.example.com/endpoint"))
                    XCTAssertEqual(actualUrlString, "http://www.example.com/endpoint")
                }
            }
            
            it("ensures that newly initialized network data tasks call resume() to initiate the request") {
                Task {
                    let fakeNetworkSession = FakeNetworkSession()
                    let networkHttp = NetworkHttp(
                        baseUrl: "http://www.example.com",
                        networkSession: fakeNetworkSession
                    )
                    
                    let spySessionDataTask = SpySessionDataTask()
                    fakeNetworkSession.dataTask_returnValue = spySessionDataTask
                    
                    
                    do {
                        let _ = try await networkHttp.get(endpoint: "")
                    }
                    
                    
                    // Why did this Nimble assertion run without issues?
                    expect(spySessionDataTask.resume_wasCalled).to(beTrue())
                }
            }
            
            it("returns a future which resolves the request with response data") {
                Task {
                    // This test uses the FakeNetworkSession to allow us to set data on the dataTask.
                    let fakeNetworkSession = FakeNetworkSession()
                    let networkHttp = NetworkHttp(
                        baseUrl: "http://www.example.com",
                        networkSession: fakeNetworkSession
                    )
                    
                    let responseData = "GET Response".data(using: String.Encoding.utf8)
                    fakeNetworkSession.dataTask_completionHandler_inputs = (
                        maybeData: responseData,
                        maybeResponse: nil,
                        maybeError: nil
                    )
                    
                    
                    var actualData: Data?
                    do {
                        actualData = try await networkHttp.get(endpoint: "http://www.example.com")
                    }
                    
                    
                    expect(actualData).to(equal(responseData))
                }
            }
        }
        
//        describe("http post requests") {
//            var spyNetworkSession: SpyNetworkSession!
//
//            describe("the post request") {
//                beforeEach {
//                    spyNetworkSession = SpyNetworkSession()
//                    networkHttp = NetworkHttp(
//                        baseUrl: "http://www.example.com",
//                        networkSession: spyNetworkSession
//                    )
//
//
////                    let _ = networkHttp.post(
////                        endpoint: "/endpoint",
////                        requestBody: "some data".data(using: .utf8)!
////                    )
//                }
//
//                it("sets the request type to POST") {
//                    let actualHttpMethod = spyNetworkSession.dataTask_argument_request?.httpMethod
//                    expect(actualHttpMethod).to(equal("POST"))
//                }
//
//                it("sets the content type") {
//                    let actualContentType = spyNetworkSession.dataTask_argument_request?.allHTTPHeaderFields?["Content-Type"]
//                    expect(actualContentType).to(equal("application/json; charset=utf-8"))
//                }
//
//                it("makes a request to the correct endpoint") {
//                    let actualUrlString = spyNetworkSession.dataTask_argument_request?.url?.absoluteString
//                    expect(actualUrlString).to(equal("http://www.example.com/endpoint"))
//                }
//
//                it("sets the request body") {
//                    let actualBodyData = spyNetworkSession.dataTask_argument_request?.httpBody
//                    expect(actualBodyData).to(equal("some data".data(using: .utf8)))
//                }
//            }
//
//            it("ensures that newly initialized network data tasks call resume() to initiate the request") {
//                let fakeNetworkSession = FakeNetworkSession()
//                networkHttp = NetworkHttp(
//                    baseUrl: "http://www.example.com",
//                    networkSession: fakeNetworkSession
//                )
//
//                let spySessionDataTask = SpySessionDataTask()
//                fakeNetworkSession.dataTask_returnValue = spySessionDataTask
//
//
////                let _ = networkHttp.post(
////                    endpoint: "http://www.example.com",
////                    requestBody: "some data".data(using: .utf8)!
////                )
//
//
//                expect(spySessionDataTask.resume_wasCalled).to(beTrue())
//            }
//
//            it("resolves the request with response data") {
//                // This test uses the FakeNetworkSession to allow us to set data on the dataTask.
//                let fakeNetworkSession = FakeNetworkSession()
//                networkHttp = NetworkHttp(
//                    baseUrl: "http://www.example.com",
//                    networkSession: fakeNetworkSession
//                )
//
//                let responseData = "POST Response".data(using: String.Encoding.utf8)
//                fakeNetworkSession.dataTask_completionHandler_inputs = (
//                    maybeData: responseData,
//                    maybeResponse: nil,
//                    maybeError: nil
//                )
//
//
////                let maybeResponseFuture = networkHttp.post(
////                    endpoint: "http://www.example.com",
////                    requestBody: "some data".data(using: .utf8)!
////                )
//
//                var actualData: Data?
////                maybeResponseFuture.onSuccess { data in
////                    actualData = data
////                }
//
//
//                expect(actualData).toEventually(equal(responseData))
//            }
//        }
    }
}
