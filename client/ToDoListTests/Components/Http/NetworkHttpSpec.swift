import Quick
import Nimble
@testable import ToDoList

class NetworkHttpSpec: QuickSpec {
    override func spec() {
        describe("http get requests") {
            it("makes a request to the correct endpoint") {
                let spyNetworkSession = SpyNetworkSession()
                let networkHttp = NetworkHttp(networkSession: spyNetworkSession)


                networkHttp.get(url: "http://www.google.com")


                expect(spyNetworkSession.dataTask_argument_request?.url?.absoluteString)
                    .to(equal("http://www.google.com"))
            }
        }
    }
}
