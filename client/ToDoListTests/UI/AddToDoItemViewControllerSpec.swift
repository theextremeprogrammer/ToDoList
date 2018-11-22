import Quick
import Nimble
import Succinct
@testable import ToDoList

class AddToDoItemViewControllerSpec: QuickSpec {
    override func spec() {
        describe("the add to do item view controller") {
            var addToDoItemVC: AddToDoItemViewController!
            
            var spyRouter: SpyRouter!
            var spyToDoListRepo: SpyToDoListRepo!
            
            beforeEach {
                spyRouter = SpyRouter()
                spyToDoListRepo = SpyToDoListRepo()
                
                addToDoItemVC = AddToDoItemViewController(
                    router: spyRouter,
                    toDoListRepository: spyToDoListRepo
                )
                addToDoItemVC.loadViewControllerForUnitTest()
            }
            
            describe("the visual layout") {
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
                    let titleTextField = addToDoItemVC.findTextField(withExactPlaceholderText: "Edit blog post")
                    titleTextField!.text = "Buy groceries"
                    
                    
                    addToDoItemVC.tapBarButtonItem(withSystemItem: .done)
                    
                    
                    let expectedNewToDo = NewToDo(title: "Buy groceries")
                    expect(spyToDoListRepo.create_argument_newToDo).to(equal(expectedNewToDo))
                }
            }
        }
    }
}
