import Quick
import Nimble
import Succinct
import BrightFutures
@testable import ToDoList

class ToDoListTableViewControllerSpec: QuickSpec {
    override func spec() {
        describe("to do list table view controller") {
            var toDoListTableViewController: ToDoListViewController!
            var getAllPromise: Promise<[ToDoItem], RepoError>!

            beforeEach {
                getAllPromise = Promise<[ToDoItem], RepoError>()
                
                let stubToDoListRepository = StubToDoListRepository()
                stubToDoListRepository.getAll_returnValue = getAllPromise.future
                
                toDoListTableViewController = ToDoListViewController(
                    toDoListRepo: stubToDoListRepository
                )
                toDoListTableViewController.loadViewControllerForUnitTest()
            }
            
            it("displays a title in the navigation bar") {
                expect(toDoListTableViewController.title).to(equal("To Do List"))
            }
            
            it("displays the title of several to do list items") {
                getAllPromise.success([
                    ToDoItem(title: "Get groceries"),
                    ToDoItem(title: "Pick up dry cleaning")
                ])
                
                
                expect(toDoListTableViewController.hasLabel(withExactText: "Get groceries")).toEventually(beTrue())
                expect(toDoListTableViewController.hasLabel(withExactText: "Pick up dry cleaning")).toEventually(beTrue())
            }
        }
    }
}
