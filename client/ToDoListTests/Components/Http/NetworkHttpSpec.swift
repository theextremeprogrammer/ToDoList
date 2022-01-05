import Quick
import Nimble
import Foundation
@testable import ToDoList

class NetworkHttpSpec: QuickSpec {
    override func spec() {
        var networkHttp: NetworkHttp!

        describe("http get requests") {
            it("makes a request to the correct endpoint") {
                // This test uses the SpyNetworkSession since we are only spying on the data sent to it.
                let spyNetworkSession = SpyNetworkSession()
                networkHttp = NetworkHttp(
                    baseUrl: "http://www.example.com",
                    networkSession: spyNetworkSession
                )


                let _ = networkHttp.get(endpoint: "/endpoint")


                let actualUrlString = spyNetworkSession.dataTask_argument_request?.url?.absoluteString
                expect(actualUrlString).to(equal("http://www.example.com/endpoint"))
            }

            it("returns a future which resolves the request with response data") {
                // This test uses the FakeNetworkSession to allow us to set data on the dataTask.
                let fakeNetworkSession = StubNetworkSession()
                networkHttp = NetworkHttp(
                    baseUrl: "http://www.example.com",
                    networkSession: fakeNetworkSession
                )

                let responseData = "GET Response".data(using: String.Encoding.utf8)!
                fakeNetworkSession.dataTask_completionPromise_inputs = (
                    data: responseData,
                    response: URLResponse()
                )


                let maybeResponsePromise = networkHttp.get(endpoint: "http://www.example.com")

                var actualData: Data?
                maybeResponsePromise
                    .done { data in
                        actualData = data
                    }
                    .catch { _ in }


                expect(actualData).toEventually(equal(responseData))
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
//                    let _ = networkHttp.post(
//                        endpoint: "/endpoint",
//                        requestBody: "some data".data(using: .utf8)!
//                    )
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
//                let _ = networkHttp.post(
//                    endpoint: "http://www.example.com",
//                    requestBody: "some data".data(using: .utf8)!
//                )
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
//                let maybeResponseFuture = networkHttp.post(
//                    endpoint: "http://www.example.com",
//                    requestBody: "some data".data(using: .utf8)!
//                )
//
//                var actualData: Data?
//                maybeResponseFuture.onSuccess { data in
//                    actualData = data
//                }
//
//
//                expect(actualData).toEventually(equal(responseData))
//            }
//        }
    }
}
