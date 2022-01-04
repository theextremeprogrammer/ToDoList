import Quick
import Nimble
import Foundation
@testable import ToDoList
import XCTest

final class NetworkHttpGetTest: XCTestCase {
    func testHttpGet_makesARequestToTheCorrectEndPoint() async {
        // This test uses the SpyNetworkSession since we are only spying on the data sent to it.
        let spyNetworkSession = SpyNetworkSession()
        let networkHttp = NetworkHttp(
            baseUrl: "http://www.example.com",
            networkSession: spyNetworkSession
        )
    
    
        do {
            let _ = try await networkHttp.get(endpoint: "/endpoint")
        } catch {}


        let actualUrlString = spyNetworkSession.dataTask_argument_request?.url?.absoluteString
        XCTAssertEqual(actualUrlString, "http://www.example.com/endpoint")
    }
    
    func testHttpGet_ensuresThatNewlyInitializedNetworkDataTasksInitiateTheRequest() async {
        let stubNetworkSession = StubNetworkSession()
        let networkHttp = NetworkHttp(
            baseUrl: "http://www.example.com",
            networkSession: stubNetworkSession
        )

        let spySessionDataTask = SpySessionDataTask()
        stubNetworkSession.dataTask_returnValue = spySessionDataTask
        stubNetworkSession.dataTask_completionHandler_inputs = (
            maybeData: Data(),
            maybeResponse: nil,
            maybeError: nil
        )


        do {
            let _ = try await networkHttp.get(endpoint: "")
        } catch {}


        XCTAssertTrue(spySessionDataTask.resume_wasCalled)
    }
    
    func testHttpGet_returnsResponseData() async {
        // This test uses the stubNetworkSession to allow us to set data on the dataTask.
        let stubNetworkSession = StubNetworkSession()
        let networkHttp = NetworkHttp(
            baseUrl: "http://www.example.com",
            networkSession: stubNetworkSession
        )

        let responseData = "GET Response".data(using: String.Encoding.utf8)
        stubNetworkSession.dataTask_completionHandler_inputs = (
            maybeData: responseData,
            maybeResponse: nil,
            maybeError: nil
        )


        var actualData: Data?
        do {
            actualData = try await networkHttp.get(endpoint: "http://www.example.com")
        } catch {}


        expect(actualData).to(equal(responseData))
    }
}

final class NetworkHttpSpec: QuickSpec {
    override func spec() {
////        describe("http post requests") {
////            var spyNetworkSession: SpyNetworkSession!
////
////            describe("the post request") {
////                beforeEach {
////                    spyNetworkSession = SpyNetworkSession()
////                    networkHttp = NetworkHttp(
////                        baseUrl: "http://www.example.com",
////                        networkSession: spyNetworkSession
////                    )
////
////
//////                    let _ = networkHttp.post(
//////                        endpoint: "/endpoint",
//////                        requestBody: "some data".data(using: .utf8)!
//////                    )
////                }
////
////                it("sets the request type to POST") {
////                    let actualHttpMethod = spyNetworkSession.dataTask_argument_request?.httpMethod
////                    expect(actualHttpMethod).to(equal("POST"))
////                }
////
////                it("sets the content type") {
////                    let actualContentType = spyNetworkSession.dataTask_argument_request?.allHTTPHeaderFields?["Content-Type"]
////                    expect(actualContentType).to(equal("application/json; charset=utf-8"))
////                }
////
////                it("makes a request to the correct endpoint") {
////                    let actualUrlString = spyNetworkSession.dataTask_argument_request?.url?.absoluteString
////                    expect(actualUrlString).to(equal("http://www.example.com/endpoint"))
////                }
////
////                it("sets the request body") {
////                    let actualBodyData = spyNetworkSession.dataTask_argument_request?.httpBody
////                    expect(actualBodyData).to(equal("some data".data(using: .utf8)))
////                }
////            }
////
////            it("ensures that newly initialized network data tasks call resume() to initiate the request") {
////                let stubNetworkSession = stubNetworkSession()
////                networkHttp = NetworkHttp(
////                    baseUrl: "http://www.example.com",
////                    networkSession: stubNetworkSession
////                )
////
////                let spySessionDataTask = SpySessionDataTask()
////                stubNetworkSession.dataTask_returnValue = spySessionDataTask
////
////
//////                let _ = networkHttp.post(
//////                    endpoint: "http://www.example.com",
//////                    requestBody: "some data".data(using: .utf8)!
//////                )
////
////
////                expect(spySessionDataTask.resume_wasCalled).to(beTrue())
////            }
////
////            it("resolves the request with response data") {
////                // This test uses the stubNetworkSession to allow us to set data on the dataTask.
////                let stubNetworkSession = stubNetworkSession()
////                networkHttp = NetworkHttp(
////                    baseUrl: "http://www.example.com",
////                    networkSession: stubNetworkSession
////                )
////
////                let responseData = "POST Response".data(using: String.Encoding.utf8)
////                stubNetworkSession.dataTask_completionHandler_inputs = (
////                    maybeData: responseData,
////                    maybeResponse: nil,
////                    maybeError: nil
////                )
////
////
//////                let maybeResponseFuture = networkHttp.post(
//////                    endpoint: "http://www.example.com",
//////                    requestBody: "some data".data(using: .utf8)!
//////                )
////
////                var actualData: Data?
//////                maybeResponseFuture.onSuccess { data in
//////                    actualData = data
//////                }
////
////
////                expect(actualData).toEventually(equal(responseData))
////            }
////        }
    }
}
