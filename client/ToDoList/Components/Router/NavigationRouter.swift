import UIKit

protocol Router {
    var navigationController: UINavigationController { get }

    func showToDoListViewController()
    func showAddToDoItemViewController()
    func dismissModalVC()
}

final class NavigationRouter {
    let navigationController: UINavigationController
    let animated: Bool
    
    init(navigationController: UINavigationController,
         animated: Bool
    ) {
        self.navigationController = navigationController
        self.animated = animated
    }
}

extension NavigationRouter: Router {
    func showToDoListViewController() {
        let http = NetworkHttp(networkSession: URLSession.shared)
        let toDoListRepo = NetworkToDoListRepository(
            http: http
        )
        
        let toDoListViewController = ToDoListViewController(
            toDoListRepo: toDoListRepo,
            reloader: DefaultReloader()
        )
        
        navigationController.setViewControllers(
            [toDoListViewController],
            animated: animated
        )
    }
    
    func showAddToDoItemViewController() {
        let addToDoItemVC = AddToDoItemViewController()
        
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
