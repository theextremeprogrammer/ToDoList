import XCTest
@testable import ToDoList

final class NetworkHttpPostTest: XCTestCase {
    func testMakesRequestToCorrectEndpoint() async {
        let spyNetworkSession = SpyNetworkSession()
        let networkHttp = NetworkHttp(
            baseUrl: "http://www.example.com",
            networkSession: spyNetworkSession
        )


        do {
            let _ = try await networkHttp.post(
                endpoint: "/endpoint",
                requestBody: "some data".data(using: .utf8)!
            )
        } catch {}
        
        
        let actualUrlString = spyNetworkSession.dataTask_argument_request?.url?.absoluteString
        XCTAssertEqual(actualUrlString, "http://www.example.com/endpoint")
    }
    
    func testSetsRequestTypeToPost() async {
        let spyNetworkSession = SpyNetworkSession()
        let networkHttp = NetworkHttp(
            baseUrl: "http://www.example.com",
            networkSession: spyNetworkSession
        )


        do {
            let _ = try await networkHttp.post(
                endpoint: "/endpoint",
                requestBody: "some data".data(using: .utf8)!
            )
        } catch {}
        
        
        let actualHttpMethod = spyNetworkSession.dataTask_argument_request?.httpMethod
        XCTAssertEqual(actualHttpMethod, "POST")
    }
    
    func testSetsContentType() async {
        let spyNetworkSession = SpyNetworkSession()
        let networkHttp = NetworkHttp(
            baseUrl: "http://www.example.com",
            networkSession: spyNetworkSession
        )


        do {
            let _ = try await networkHttp.post(
                endpoint: "/endpoint",
                requestBody: "some data".data(using: .utf8)!
            )
        } catch {}
        
        
        let actualContentType = spyNetworkSession.dataTask_argument_request?.allHTTPHeaderFields?["Content-Type"]
        XCTAssertEqual(actualContentType, "application/json; charset=utf-8")
    }
    
    func testSetsRequestBody() async {
        let spyNetworkSession = SpyNetworkSession()
        let networkHttp = NetworkHttp(
            baseUrl: "http://www.example.com",
            networkSession: spyNetworkSession
        )


        do {
            let _ = try await networkHttp.post(
                endpoint: "/endpoint",
                requestBody: "some data".data(using: .utf8)!
            )
        } catch {}
        
        
        let actualBodyData = spyNetworkSession.dataTask_argument_request?.httpBody
        XCTAssertEqual(actualBodyData, "some data".data(using: .utf8))
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
            let _ = try await networkHttp.post(
                endpoint: "http://www.example.com",
                requestBody: "some data".data(using: .utf8)!
            )

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

        let responseData = "POST Response".data(using: String.Encoding.utf8)
        stubNetworkSession.dataTask_completionHandler_inputs = (
            maybeData: responseData,
            maybeResponse: nil,
            maybeError: nil
        )


        var actualData: Data?
        do {
            actualData = try await networkHttp.post(
                endpoint: "http://www.example.com",
                requestBody: "some data".data(using: .utf8)!
            )
        } catch {}


        XCTAssertEqual(actualData, responseData)
    }
}
