import Quick
import Nimble
import Succinct
@testable import ToDoList

class AddToDoItemViewControllerSpec: QuickSpec {
    override func spec() {
        describe("the add to do item view controller") {
            var addToDoItemVC: AddToDoItemViewController!
            
            var spyRouter: SpyRouter!
            
            beforeEach {
                spyRouter = SpyRouter()
                
                addToDoItemVC = AddToDoItemViewController(
                    router: spyRouter
                )
                addToDoItemVC.loadViewControllerForUnitTest()
            }
            
            describe("the visual layout") {
                it("displays a title in the navigation bar") {
                    expect(addToDoItemVC.title).to(equal("Add To Do Item"))
                }
                
                it("dismisses the view controller when tapping the 'x' bar button item") {
                    addToDoItemVC.tapBarButtonItem(withSystemItem: .cancel)
                    
                    
                    expect(spyRouter.dismissModalVC_wasCalled).to(beTrue())
                }
            }
        }
    }
}
