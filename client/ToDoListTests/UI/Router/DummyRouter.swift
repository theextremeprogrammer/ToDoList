import UIKit
@testable import ToDoList

final class DummyRouter: Router {
    var navigationController: UINavigationController {
        get {
            return UINavigationController(nibName: nil, bundle: nil)
        }
    }
    
    func showToDoListViewController() {
        assertionFailure("showToDoListViewController() - not expected to have been called")
    }
    
    func showAddToDoItemViewController(delegate: AddToDoItemDelegate) {
        assertionFailure("showAddToDoItemViewController() - not expected to have been called")
    }
    
    func dismissModalVC() {
        assertionFailure("dismissModalVC() - not expected to have been called")
    }
}
