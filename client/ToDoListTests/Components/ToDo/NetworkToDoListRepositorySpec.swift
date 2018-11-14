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

            beforeEach {
                spyHttp = SpyHttp()
                toDoListRepo = NetworkToDoListRepository(http: spyHttp)
            }
            
            it("hits the expected endpoint") {
                let _ = toDoListRepo.getAll()
                
                
                expect(spyHttp.get_argument_url).to(equal("http://localhost:8080/todolist"))
            }
            
            it("returns a future with hard-coded to do items") {
                var toDoItems: [ToDoItem]? = nil

                
                SimpleXCTestExpectation.execute(testCase: self) { testExpectation in
                    toDoListRepo
                        .getAll()
                        .onSuccess { returnedToDoItems in
                            toDoItems = returnedToDoItems
                            testExpectation.fulfill()
                        }
                }

                
                expect(toDoItems?.count).to(equal(2))
                expect(toDoItems?.first?.title).to(equal("Get groceries"))
                expect(toDoItems?.last?.title).to(equal("Pick up dry cleaning"))
            }
        }
    }
}
