import Quick
import Nimble
import Succinct
import BrightFutures
@testable import ToDoList

class ToDoListTableViewControllerSpec: QuickSpec {
    override func spec() {
        describe("to do list table view controller") {
            var toDoListTableViewController: ToDoListViewController!
            
            var spyRouter: SpyRouter!
            var spyReloader: SpyReloader!
            var getAllPromise: Promise<[ToDoItem], RepoError>!
            
            describe("displaying the list of to do items") {
                beforeEach {
                    getAllPromise = Promise<[ToDoItem], RepoError>()
                    
                    let stubToDoListRepository = StubToDoListRepository()
                    stubToDoListRepository.getAll_returnValue = getAllPromise.future
                    
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
                    getAllPromise.success([
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
                    getAllPromise.success([])
                    
                    
                    expect(spyReloader.reload_argument_reloadable).toEventually(beAKindOf(UITableView.self))
                }
            }
            
            describe("navigation") {
                beforeEach {
                    let stubToDoListRepository = StubToDoListRepository()
                    stubToDoListRepository.getAll_returnValue = Future()
                    
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
                    let stubToDoListRepository = StubToDoListRepository()
                    stubToDoListRepository.getAll_returnValue = Future()

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
