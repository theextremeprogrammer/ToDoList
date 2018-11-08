import Quick
import Nimble
import Succinct
import BrightFutures
@testable import ToDoList

class NetworkToDoListRepositorySpec: QuickSpec {
    override func spec() {
        describe("the network to do list repository") {
            var toDoListRepo: NetworkToDoListRepository!

            beforeEach {
                toDoListRepo = NetworkToDoListRepository()
            }
            
            it("returns a future with hard-coded to do items") {
                var toDoItems: [ToDoItem]? = nil

                
                SimpleXCTestExpectation.execute(testObject: self) { successExpectation in
                    let getAllFuture = toDoListRepo.getAll()
                    
                    getAllFuture.onSuccess { returnedToDoItems in
                        toDoItems = returnedToDoItems
                        successExpectation.fulfill()
                    }
                }

                
                expect(toDoItems?.count).to(equal(2))
                expect(toDoItems?.first?.title).to(equal("Get groceries"))
                expect(toDoItems?.last?.title).to(equal("Pick up dry cleaning"))
            }
        }
    }
}
