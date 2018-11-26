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
                    
                    addToDoItemVC = AddToDoItemViewController(
                        router: spyRouter,
                        toDoListRepository: DummyToDoListRepository()
                    )
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
                var spyToDoListRepo: SpyToDoListRepo!
                
                beforeEach {
                    spyToDoListRepo = SpyToDoListRepo()
                    
                    addToDoItemVC = AddToDoItemViewController(
                        router: DummyRouter(),
                        toDoListRepository: spyToDoListRepo
                    )
                    addToDoItemVC.loadViewControllerForUnitTest()
                }
                
                it("tells the repo to create the new to do with the title") {
                    let titleTextField = addToDoItemVC.findTextField(withExactPlaceholderText: "Edit blog post")
                    titleTextField!.text = "Buy groceries"


                    addToDoItemVC.tapBarButtonItem(withSystemItem: .done)


                    let expectedNewToDo = NewToDoItemBuilder()
                        .withTitle("Buy groceries")
                        .build()

                    expect(spyToDoListRepo.create_argument_newToDo).to(equal(expectedNewToDo))
                }
            }
        }
    }
}
