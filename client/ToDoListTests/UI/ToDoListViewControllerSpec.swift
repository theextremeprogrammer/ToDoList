import Quick
import Nimble
import Succinct
import BrightFutures
@testable import ToDoList

class ToDoListTableViewControllerSpec: QuickSpec {
    override func spec() {
        describe("to do list table view controller") {
            var toDoListTableViewController: ToDoListViewController!
            
            var spyReloader: SpyReloader!
            var getAllPromise: Promise<[ToDoItem], RepoError>!

            beforeEach {
                getAllPromise = Promise<[ToDoItem], RepoError>()
                
                let stubToDoListRepository = StubToDoListRepository()
                stubToDoListRepository.getAll_returnValue = getAllPromise.future
                
                spyReloader = SpyReloader()
                
                toDoListTableViewController = ToDoListViewController(
                    toDoListRepo: stubToDoListRepository,
                    reloader: spyReloader
                )
                toDoListTableViewController.loadViewControllerForUnitTest()
            }
            
            it("displays a title in the navigation bar") {
                expect(toDoListTableViewController.title).to(equal("To Do List"))
            }
            
            it("displays the title of several to do list items") {
                getAllPromise.success([
                    ToDoItem(id: 1, title: "Get groceries", completed: false),
                    ToDoItem(id: 2, title: "Pick up dry cleaning", completed: false),
                ])
                
                
                expect(toDoListTableViewController.hasLabel(withExactText: "Get groceries")).toEventually(beTrue())
                expect(toDoListTableViewController.hasLabel(withExactText: "Pick up dry cleaning")).toEventually(beTrue())
            }
            
            it("reloads the tableview's data once the repository returns data") {
                getAllPromise.success([])

                
                expect(spyReloader.reload_argument_reloadable).toEventually(beAKindOf(UITableView.self))
            }
        }
    }
}
