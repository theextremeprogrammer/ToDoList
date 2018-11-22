import Quick
import Nimble
@testable import ToDoList

class ToDoItemSpec: QuickSpec {
    override func spec() {
        describe("to do item equality") {
            it("knows when two objects are equal") {
                let toDoItem1 = ToDoItem(id: 1, title: "A", completed: true)
                let toDoItem2 = ToDoItem(id: 1, title: "A", completed: true)
                
                
                expect(toDoItem1).to(equal(toDoItem2))
            }
            
            it("knows when two objects are not equal: id") {
                let toDoItem1 = ToDoItem(id: 1, title: "A", completed: true)
                let toDoItem2 = ToDoItem(id: 99, title: "A", completed: true)
                
                
                expect(toDoItem1).toNot(equal(toDoItem2))
            }

            it("knows when two objects are not equal: title") {
                let toDoItem1 = ToDoItem(id: 1, title: "A", completed: true)
                let toDoItem2 = ToDoItem(id: 1, title: "ABC", completed: true)


                expect(toDoItem1).toNot(equal(toDoItem2))
            }

            it("knows when two objects are not equal: completed") {
                let toDoItem1 = ToDoItem(id: 1, title: "A", completed: true)
                let toDoItem2 = ToDoItem(id: 1, title: "A", completed: false)


                expect(toDoItem1).toNot(equal(toDoItem2))
            }
        }
    }
}

