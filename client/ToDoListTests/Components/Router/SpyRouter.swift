import UIKit
@testable import ToDoList

class SpyRouter: Router {
    var navigationController: UINavigationController {
        get {
            return UINavigationController(nibName: nil, bundle: nil)
        }
    }
    
    
    
    private(set) var showToDoListViewController_wasCalled: Bool = false
    func showToDoListViewController() {
        showToDoListViewController_wasCalled = true
    }
    
    
    
    private(set) var showAddToDoItemViewController_argument_delegate: AddToDoItemDelegate? = nil
    func showAddToDoItemViewController(delegate: AddToDoItemDelegate) {
        showAddToDoItemViewController_argument_delegate = delegate
    }
    
    
    
    private(set) var dismissModalVC_wasCalled: Bool = false
    func dismissModalVC() {
        dismissModalVC_wasCalled = true
    }
}
