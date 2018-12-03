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
            
            describe("getting all to do list items") {
                beforeEach {
                    spyHttp = SpyHttp()
                    toDoListRepo = NetworkToDoListRepository(http: spyHttp)
                }

                it("hits the expected endpoint") {
                    let _ = toDoListRepo.getAll()


                    expect(spyHttp.get_argument_endpoint).to(equal("/todos"))
                }

                context("when the request is successful") {
                    it("returns a future with to do items from the http response") {
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

                            // We can use a multi-string literal 
                            let jsonResponse = """
                                [
                                  { 
                                    "id": 1, 
                                    "title": "Get groceries", 
                                    "completed": false
                                  },
                                  {
                                    "id": 2, 
                                    "title": "Pick up dry cleaning", 
                                    "completed": true
                                  }
                                ]
                               """
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
            }
            
            describe("creating a new to do item") {
                beforeEach {
                    spyHttp = SpyHttp()
                    toDoListRepo = NetworkToDoListRepository(http: spyHttp)
                }
                
                it("hits the expected endpoint") {
                    let newToDo = NewToDoItemBuilder()
                        .withTitle("Make restaurant reservation")
                        .build()


                    let _ = toDoListRepo.create(newToDo: newToDo)


                    expect(spyHttp.post_argument_endpoint).to(equal("/todos"))
                }

                it("passes the request body to the http request for the new to do item") {
                    let newToDo = NewToDoItemBuilder()
                        .withTitle("Make restaurant reservation")
                        .build()


                    let _ = toDoListRepo.create(newToDo: newToDo)


                    // Sadly if the JSON here doesn't perfectly match the JSON coming
                    //      back from the call then this test fails - so we cannot format
                    //      the JSON inside this string in a more readable way. This means
                    //      that auto-formatting will break this layout. There must be a
                    //      better way.
                    let expectedJSON = """
                        {"title":"Make restaurant reservation"}
                        """
                    let expectedJSONData = expectedJSON.data(using: .utf8)!
                    expect(spyHttp.post_argument_requestBody).to(equal(expectedJSONData))
                }
                
                context("when the request is successful") {
                    it("returns a future with the to do item from the response") {
                        let promise = Promise<Data, HttpError>()
                        spyHttp.post_returnValue = promise.future

                        let newToDo = NewToDoItemBuilder()
                            .withTitle("Make restaurant reservation")
                            .build()


                        var returnedToDoItem: ToDoItem? = nil
                        SimpleXCTestExpectation.execute(testCase: self) { testExpectation in
                            toDoListRepo
                                .create(newToDo: newToDo)
                                .onSuccess { toDoItem in
                                    returnedToDoItem = toDoItem
                                    testExpectation.fulfill()
                                }

                            let jsonResponse = """
                                {
                                  "id": 99,
                                  "title": "Make restaurant reservation",
                                  "completed": false
                                }
                               """
                            promise.success(jsonResponse.data(using: .utf8)!)
                        }


                        let expectedToDoItem = ToDoItemBuilder()
                            .withId(99)
                            .withTitle("Make restaurant reservation")
                            .withCompleted(false)
                            .build()
                        expect(returnedToDoItem).to(equal(expectedToDoItem))
                    }
                }
            }
        }
    }
}
