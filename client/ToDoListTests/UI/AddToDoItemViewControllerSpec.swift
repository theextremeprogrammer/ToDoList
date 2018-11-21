import Quick
import Nimble
import Succinct
@testable import ToDoList

class AddToDoItemViewControllerSpec: QuickSpec {
    override func spec() {
        describe("the add to do item view controller") {
            var addToDoItemVC: AddToDoItemViewController!
            
            beforeEach {
                addToDoItemVC = AddToDoItemViewController()
                addToDoItemVC.loadViewControllerForUnitTest()
            }
            
            describe("the visual layout") {
                it("displays a title in the navigation bar") {
                    expect(addToDoItemVC.title).to(equal("Add To Do Item"))
                }
            }
        }
    }
}
