@testable import ToDoList

class SpyRouter: Router {
    private(set) var showAddToDoItemViewController_wasCalled: Bool = false
    func showAddToDoItemViewController() {
        showAddToDoItemViewController_wasCalled = true
    }
}
