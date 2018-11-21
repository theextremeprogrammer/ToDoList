import UIKit

protocol Router {
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
        // TODO
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
