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
    
    private(set) var showAddToDoItemViewController_wasCalled: Bool = false
    func showAddToDoItemViewController() {
        showAddToDoItemViewController_wasCalled = true
    }
    
    private(set) var dismissModalVC_wasCalled: Bool = false
    func dismissModalVC() {
        dismissModalVC_wasCalled = true
    }
}
