import Quick
import Nimble
import Succinct
import BrightFutures
@testable import ToDoList

class NetworkToDoListRepositorySpec: QuickSpec {
    override func spec() {
        describe("the network to do list repository") {
            var toDoListRepo: NetworkToDoListRepository!
            var spyHttp: SpyHttp!
            
            describe("get all to do list items") {
                beforeEach {
                    spyHttp = SpyHttp()
                    toDoListRepo = NetworkToDoListRepository(http: spyHttp)
                }
                
                it("hits the expected endpoint") {
                    let _ = toDoListRepo.getAll()
                    
                    
                    expect(spyHttp.get_argument_url).to(equal("http://localhost:8080/todos"))
                }
                
                it("returns a future with hard-coded to do items") {
                    let promise = Promise<Data, HttpError>()
                    spyHttp.get_returnValue = promise.future
                    
                    
                    var toDoItems: [ToDoItem]? = nil
                    SimpleXCTestExpectation.execute(testCase: self) { testExpectation in
                        toDoListRepo
                            .getAll()
                            .onSuccess { returnedToDoItems in
                                toDoItems = returnedToDoItems
                                testExpectation.fulfill()
                        }
                        
                        // JSON is hard to format as a string so it can be easily manipulated.
                        //      Note: it's possible to configure this in another IDE, such as
                        //      IntelliJ, and then copy/paste it into Xcode or AppCode.
                        let jsonResponse = "" +
                            "[" +
                            "  {" +
                            "    \"id\": 1," +
                            "    \"title\": \"Get groceries\"," +
                            "    \"completed\": false" +
                            "  }," +
                            "  {" +
                            "    \"id\": 2," +
                            "    \"title\": \"Pick up dry cleaning\"," +
                            "    \"completed\": true" +
                            "  }" +
                        "]"
                        promise.success(jsonResponse.data(using: .utf8)!)
                    }
                    
                    
                    expect(toDoItems?.count).to(equal(2))
                    expect(toDoItems?.first?.id).to(equal(1))
                    expect(toDoItems?.first?.title).to(equal("Get groceries"))
                    expect(toDoItems?.first?.completed).to(equal(false))
                    expect(toDoItems?.last?.id).to(equal(2))
                    expect(toDoItems?.last?.title).to(equal("Pick up dry cleaning"))
                    expect(toDoItems?.last?.completed).to(equal(true))
                }
            }
            
            describe("creating a new to do item") {
                beforeEach {
                    spyHttp = SpyHttp()
                    toDoListRepo = NetworkToDoListRepository(http: spyHttp)
                }
                
                it("hits the expected endpoint") {
                    let newToDo = NewToDo(title: "Make restaurant reservation")
                    
                    
                    toDoListRepo.create(newToDo: newToDo)

                    
                    expect(spyHttp.post_argument_url).to(equal("http://localhost:8080/todos"))
                }
                
                it("passes the request body in") {
                    let newToDo = NewToDo(title: "Make restaurant reservation")
                    
                    
                    toDoListRepo.create(newToDo: newToDo)
                    

                    // Sadly if the JSON here doesn't perfectly match the JSON coming
                    //      back from the call then this test fails - so we cannot format
                    //      the JSON inside this string in a more readable way. This means
                    //      that auto-formatting will break this layout. There must be a
                    //      better way. 
                    let expectedJSON = "" +
                        "{" +
                          "\"title\":\"Make restaurant reservation\"" +
                        "}"
                    expect(spyHttp.post_argument_requestBody).to(equal(expectedJSON))
                }
            }
        }
    }
}
