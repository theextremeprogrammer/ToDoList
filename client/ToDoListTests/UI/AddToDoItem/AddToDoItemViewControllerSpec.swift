import Quick
import Nimble
import Succinct
import BrightFutures
@testable import ToDoList

class AddToDoItemViewControllerSpec: QuickSpec {
    override func spec() {
        describe("the add to do item view controller") {
            var addToDoItemVC: AddToDoItemViewController!
            
            describe("the visual layout") {
                var spyRouter: SpyRouter!
                
                beforeEach {
                    spyRouter = SpyRouter()
                    
                    addToDoItemVC = AddToDoItemViewControllerBuilder()
                        .withRouter(spyRouter)
                        .withToDoListRepo(DummyToDoListRepository())
                        .build()
                    addToDoItemVC.loadViewControllerForUnitTest()
                }
                
                it("displays a title in the navigation bar") {
                    expect(addToDoItemVC.title).to(equal("Add To Do Item"))
                }
                
                it("dismisses the view controller when tapping the 'x' bar button item") {
                    addToDoItemVC.tapBarButtonItem(withSystemItem: .stop)
                    
                    
                    expect(spyRouter.dismissModalVC_wasCalled).to(beTrue())
                }
            }

            describe("adding a new to do") {
                it("tells the repo to create the new to do with the title") {
                    let spyToDoListRepo = SpyToDoListRepo()
                    
                    addToDoItemVC = AddToDoItemViewControllerBuilder()
                        .withRouter(SpyRouter())
                        .withToDoListRepo(spyToDoListRepo)
                        .build()
                    addToDoItemVC.loadViewControllerForUnitTest()
                    
                    let titleTextField = addToDoItemVC.findTextField(withExactPlaceholderText: "Edit blog post")
                    titleTextField!.text = "Buy groceries"
                    
                    
                    addToDoItemVC.tapBarButtonItem(withSystemItem: .done)
                    
                    
                    let expectedNewToDo = NewToDoItemBuilder()
                        .withTitle("Buy groceries")
                        .build()
                    
                    expect(spyToDoListRepo.create_argument_newToDo).to(equal(expectedNewToDo))
                }
                
                context("when the request is successful") {
                    it("dismisses the modal view controller ") {
                        let promise = Promise<ToDoItem, RepoError>()

                        let spyRouter = SpyRouter()
                        
                        let stubToDoListRepo = StubToDoListRepository()
                        stubToDoListRepo.create_returnValue = promise.future
                        
                        addToDoItemVC = AddToDoItemViewControllerBuilder()
                            .withRouter(spyRouter)
                            .withToDoListRepo(stubToDoListRepo)
                            .build()
                        addToDoItemVC.loadViewControllerForUnitTest()

                        let titleTextField = addToDoItemVC.findTextField(withExactPlaceholderText: "Edit blog post")
                        titleTextField!.text = "Buy groceries"
                        
                        
                        addToDoItemVC.tapBarButtonItem(withSystemItem: .done)

                        
                        let toDoItem = ToDoItemBuilder()
                            .withTitle("Buy groceries")
                            .build()
                        promise.success(toDoItem)
                        
                        expect(spyRouter.dismissModalVC_wasCalled).toEventually(beTrue())
                    }
                    
                    it("notifies the delegate of the newly added to do item") {
                        let promise = Promise<ToDoItem, RepoError>()
                        
                        let spyRouter = SpyRouter()
                        let stubToDoListRepo = StubToDoListRepository()
                        stubToDoListRepo.create_returnValue = promise.future
                        let spyAddToDoItemDelegate = SpyAddToDoItemDelegate()

                        addToDoItemVC = AddToDoItemViewControllerBuilder()
                            .withRouter(spyRouter)
                            .withToDoListRepo(stubToDoListRepo)
                            .withDelegate(spyAddToDoItemDelegate)
                            .build()
                        addToDoItemVC.loadViewControllerForUnitTest()
                        
                        let titleTextField = addToDoItemVC.findTextField(withExactPlaceholderText: "Edit blog post")
                        titleTextField!.text = "Buy groceries"
                        
                        
                        addToDoItemVC.tapBarButtonItem(withSystemItem: .done)
                        
                        
                        let toDoItem = ToDoItemBuilder()
                            .withTitle("Buy groceries")
                            .build()
                        promise.success(toDoItem)
                        
                        expect(spyAddToDoItemDelegate.add_argument_toDoItem).toEventually(equal(toDoItem))
                    }
                }
                
                context("when the request fails") {
                    it("does not dismiss the view controller") {
                        let promise = Promise<ToDoItem, RepoError>()
                        
                        let spyRouter = SpyRouter()
                        
                        let stubToDoListRepo = StubToDoListRepository()
                        stubToDoListRepo.create_returnValue = promise.future
                        
                        addToDoItemVC = AddToDoItemViewControllerBuilder()
                            .withRouter(spyRouter)
                            .withToDoListRepo(stubToDoListRepo)
                            .build()
                        addToDoItemVC.loadViewControllerForUnitTest()
                        
                        let titleTextField = addToDoItemVC.findTextField(withExactPlaceholderText: "Edit blog post")
                        titleTextField!.text = "Buy groceries"
                        
                        
                        addToDoItemVC.tapBarButtonItem(withSystemItem: .done)
                        
                        
                        promise.failure(RepoError.undefined)
                        expect(spyRouter.dismissModalVC_wasCalled).to(beFalse())
                    }
                }
            }
        }
    }
}
