import UIKit

protocol Router {
    var navigationController: UINavigationController { get }

    func showToDoListViewController()
    func showAddToDoItemViewController(delegate: AddToDoItemDelegate)
    func dismissModalVC()
}

final class NavigationRouter {
    let navigationController: UINavigationController
    let animated: Bool

    // MARK: - Injected Dependencies
    let toDoListRepo: ToDoListRepository!
    
    init(
        navigationController: UINavigationController,
        toDoListRepo: ToDoListRepository,
        animated: Bool
    ) {
        self.navigationController = navigationController
        self.toDoListRepo = toDoListRepo
        self.animated = animated
    }
}

extension NavigationRouter: Router {
    func showToDoListViewController() {
        let toDoListViewController = ToDoListViewController(
            toDoListRepo: toDoListRepo,
            router: self,
            reloader: DefaultReloader()
        )
        
        navigationController.setViewControllers(
            [toDoListViewController],
            animated: animated
        )
    }
    
    func showAddToDoItemViewController(delegate: AddToDoItemDelegate) {
        let addToDoItemVC = AddToDoItemViewController(
            router: self,
            toDoListRepository: toDoListRepo
        )
        addToDoItemVC.delegate = delegate
        
        let parentNavController = UINavigationController(
            rootViewController: addToDoItemVC
        )
        
        navigationController.present(
            parentNavController,
            animated: animated,
            completion: nil
        )
    }
    
    func dismissModalVC() {
        navigationController.dismiss(animated: animated)
    }
}
