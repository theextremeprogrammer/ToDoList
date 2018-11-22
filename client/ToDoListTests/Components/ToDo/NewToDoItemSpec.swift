import Quick
import Nimble
@testable import ToDoList

class NewToDoItemSpec: QuickSpec {
    override func spec() {
        describe("new to do item equality") {
            it("knows when two objects are equal") {
                let newToDoItem1 = NewToDoItem(title: "A")
                let newToDoItem2 = NewToDoItem(title: "A")
                
                
                expect(newToDoItem1).to(equal(newToDoItem2))
            }
            
            it("knows when two objects are not equal: title") {
                let newToDoItem1 = NewToDoItem(title: "A")
                let newToDoItem2 = NewToDoItem(title: "XYZ")


                expect(newToDoItem1).toNot(equal(newToDoItem2))
            }
        }
    }
}
