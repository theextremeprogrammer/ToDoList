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
    
    let toDoListRepo: ToDoListRepository!
    
    init(navigationController: UINavigationController,
         animated: Bool
    ) {
        self.navigationController = navigationController
        self.animated = animated

        let http = NetworkHttp(
            baseUrl: "http://localhost:8080",
            networkSession: URLSession.shared
        )
        toDoListRepo = NetworkToDoListRepository(
            http: http
        )
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
            toDoListRepository: toDoListRepo,
            delegate: delegate
        )
        
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
