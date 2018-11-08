import Quick
import Nimble
import Succinct
@testable import ToDoList

class ToDoListTableViewControllerSpec: QuickSpec {
    override func spec() {
        describe("to do list table view controller") {
            it("displays a title in the navigation bar") {
                let toDoListTableViewController = ToDoListViewController()
                toDoListTableViewController.loadViewControllerForUnitTest()


                expect(toDoListTableViewController.title).to(equal("To Do List"))
            }
            
            it("displays the title of several to do list items") {
                let toDoListTableViewController = ToDoListViewController()
                toDoListTableViewController.loadViewControllerForUnitTest()
                
                
                expect(toDoListTableViewController.hasLabel(withExactText: "Get groceries")).to(beTrue())
                expect(toDoListTableViewController.hasLabel(withExactText: "Pick up dry cleaning")).to(beTrue())
            }
        }
    }
}
