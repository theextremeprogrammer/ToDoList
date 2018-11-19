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
    }
}
