import Quick
import Nimble
import Succinct
import BrightFutures
@testable import ToDoList

class ToDoListTableViewControllerSpec: QuickSpec {
    override func spec() {
        var toDoListTableViewController: ToDoListViewController!

        describe("to do list table view controller") {
            var stubToDoListRepository: StubToDoListRepository!
            var spyRouter: SpyRouter!
            var spyReloader: SpyReloader!

            describe("displaying the list of to do items") {
                beforeEach {
                    stubToDoListRepository = StubToDoListRepository()
                    spyReloader = SpyReloader()
                    
                    toDoListTableViewController = ToDoListViewControllerBuilder()
                        .withToDoListRepo(stubToDoListRepository)
                        .withReloader(spyReloader)
                        .build()
                    
                    toDoListTableViewController.loadViewControllerForUnitTest()
                }
                
                it("displays a title in the navigation bar") {
                    expect(toDoListTableViewController.title).to(equal("To Do List"))
                }
                
                it("displays the title of several to do list items") {
                    stubToDoListRepository.getAll_returnPromise.success([
                        ToDoItemBuilder()
                            .withTitle("Get groceries")
                            .build(),
                        ToDoItemBuilder()
                            .withTitle("Pick up dry cleaning")
                            .build()
                    ])
                    
                    
                    expect(toDoListTableViewController.hasLabel(withExactText: "Get groceries")).toEventually(beTrue())
                    expect(toDoListTableViewController.hasLabel(withExactText: "Pick up dry cleaning")).toEventually(beTrue())
                }
                
                it("reloads the tableview's data once the repository returns data") {
                    stubToDoListRepository.getAll_returnPromise.success([])
                    
                    
                    expect(spyReloader.reload_argument_reloadable).toEventually(beAKindOf(UITableView.self))
                }
            }
            
            describe("navigation") {
                beforeEach {
                    stubToDoListRepository = StubToDoListRepository()
                    spyRouter = SpyRouter()
                    
                    toDoListTableViewController = ToDoListViewControllerBuilder()
                        .withToDoListRepo(stubToDoListRepository)
                        .withRouter(spyRouter)
                        .build()
                    toDoListTableViewController.loadViewControllerForUnitTest()
                }
                
                it("navigates to the create to do item modal view controller when tapping the plus '+' button") {
                    toDoListTableViewController.tapBarButtonItem(withSystemItem: .add)
                    
                    
                    expect(spyRouter.showAddToDoItemViewController_argument_delegate).to(be(toDoListTableViewController))
                }
            }

            describe("adding a new to do item") {
                beforeEach {
                    stubToDoListRepository = StubToDoListRepository()
                    spyReloader = SpyReloader()

                    toDoListTableViewController = ToDoListViewControllerBuilder()
                        .withToDoListRepo(stubToDoListRepository)
                        .withReloader(spyReloader)
                        .build()
                    toDoListTableViewController.loadViewControllerForUnitTest()

                    let addVC = AddToDoItemViewController(
                        router: SpyRouter(),
                        toDoListRepository: FakeToDoListRepo()
                    )
                    addVC.delegate = toDoListTableViewController
                    
                    let textField = addVC.findTextField(withExactPlaceholderText: "Edit blog post")
                    textField?.text = "Laundry"
                    
                    
                    addVC.tapBarButtonItem(withSystemItem: .done)
                }

                it("displays the new to do item to the list of to do items after it has been added") {
                    expect(toDoListTableViewController.hasLabel(withExactText: "Laundry")).toEventually(beTrue())
                }

                it("reloads the tableview data after the new item has been added") {
                    expect(spyReloader.reload_argument_reloadable).toEventually(beAKindOf(UITableView.self))
                }
            }
        }
    }
}
