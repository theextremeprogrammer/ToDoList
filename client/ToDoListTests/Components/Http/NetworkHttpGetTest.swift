import XCTest
@testable import ToDoList

final class NetworkHttpGetTest: XCTestCase {
    func testMakesARequestToTheCorrectEndPoint() async {
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
    
    func testEnsuresThatNewlyInitializedNetworkDataTasksInitiateTheRequest() async {
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
    
    func testReturnsResponseData() async {
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


        XCTAssertEqual(actualData, responseData)
    }
}
