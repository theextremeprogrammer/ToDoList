import Quick
import Nimble
@testable import ToDoList

class NetworkHttpSpec: QuickSpec {
    override func spec() {
        describe("http get requests") {
            it("makes a request to the correct endpoint") {
                // This test uses the SpyNetworkSession since we are only spying on the data sent to it.
                let spyNetworkSession = SpyNetworkSession()
                let networkHttp = NetworkHttp(networkSession: spyNetworkSession)


                let _ = networkHttp.get(url: "http://www.google.com")


                let actualUrlString = spyNetworkSession.dataTask_argument_request?.url?.absoluteString
                expect(actualUrlString).to(equal("http://www.google.com"))
            }
            
            it("resolves the request with response data") {
                // This test uses the FakeNetworkSession to allow us to set data on the dataTask.
                let fakeNetworkSession = FakeNetworkSession()
                let networkHttp = NetworkHttp(networkSession: fakeNetworkSession)
                
                let responseData = "Test Response".data(using: String.Encoding.utf8)
                fakeNetworkSession.dataTask_completionHandler_inputs = (
                    maybeData: responseData,
                    maybeResponse: nil,
                    maybeError: nil
                )

                
                let maybeResponseFuture = networkHttp.get(url: "http://www.google.com")
                
                var actualData: Data?
                maybeResponseFuture.onSuccess { data in
                    actualData = data
                }

                
                expect(actualData).toEventually(equal(responseData))
            }
            
            it("ensures that newly initialized network data tasks call resume() to initiate the request") {
                let fakeNetworkSession = FakeNetworkSession()
                let networkHttp = NetworkHttp(networkSession: fakeNetworkSession)
                
                let spySessionDataTask = SpySessionDataTask()
                fakeNetworkSession.dataTask_returnValue = spySessionDataTask
                
                
                let _ = networkHttp.get(url: "http://www.google.com")
                

                expect(spySessionDataTask.resume_wasCalled).to(beTrue())
            }
        }
        
        describe("http post requests") {
            it("sets the request type to POST") {
                let spyNetworkSession = SpyNetworkSession()
                let networkHttp = NetworkHttp(networkSession: spyNetworkSession)
                
                
                let _ = networkHttp.post(
                    url: "http://www.google.com",
                    requestBody: "".data(using: .utf8)!
                )
                
                
                let actualHttpMethod = spyNetworkSession.dataTask_argument_request?.httpMethod
                expect(actualHttpMethod).to(equal("POST"))
            }
            
            it("makes a request to the correct endpoint") {
                let spyNetworkSession = SpyNetworkSession()
                let networkHttp = NetworkHttp(networkSession: spyNetworkSession)
                
                
                let _ = networkHttp.post(
                    url: "http://www.google.com",
                    requestBody: "".data(using: .utf8)!
                )
                
                
                let actualUrlString = spyNetworkSession.dataTask_argument_request?.url?.absoluteString
                expect(actualUrlString).to(equal("http://www.google.com"))
            }
            
            it("sets the request body") {
                let spyNetworkSession = SpyNetworkSession()
                let networkHttp = NetworkHttp(networkSession: spyNetworkSession)
                
                
                let _ = networkHttp.post(
                    url: "http://www.google.com",
                    requestBody: "some data".data(using: .utf8)!
                )
                
                
                let actualBodyData = spyNetworkSession.dataTask_argument_request?.httpBody
                expect(actualBodyData).to(equal("some data".data(using: .utf8)))
            }
        }
    }
}
