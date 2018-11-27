import Quick
import Nimble
@testable import ToDoList

final class NavigationRouterSpec: QuickSpec {
    override func spec() {
        var window: UIWindow?
        var rootNavController: UINavigationController!
        var navRouter: NavigationRouter!
        let animated: Bool = false
        
        beforeEach {
            rootNavController = UINavigationController()
            navRouter = NavigationRouter(
                navigationController: rootNavController,
                animated: animated
            )
        }
        
        afterEach {
            window = nil
        }

        describe("navigation") {
            it("shows the to do list view controller") {
                navRouter.showToDoListViewController()
                
                
                let topVC = rootNavController.topViewController
                expect(topVC).toEventually(beAKindOf(ToDoListViewController.self))
            }

            it("shows the add to do item view controller as a modal") {
                instantiateUIWindowForUnitTesting(rootViewController: rootNavController)


                navRouter.showAddToDoItemViewController(delegate: SpyAddToDoItemDelegate())


                let presentedNavVC = rootNavController.presentedViewController as? UINavigationController
                let presentedVC = presentedNavVC?.topViewController
                expect(presentedVC).toEventually(beAKindOf(AddToDoItemViewController.self))
            }

            it("dismisses the presented modal view controller") {
                instantiateUIWindowForUnitTesting(rootViewController: rootNavController)

                rootNavController.present(UIViewController(), animated: animated)


                navRouter.dismissModalVC()


                
                expect(rootNavController.presentedViewController).toEventually(beNil())
            }
        }

        func instantiateUIWindowForUnitTesting(rootViewController: UIViewController) {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.makeKeyAndVisible()
            window?.rootViewController = rootViewController
        }
    }
}
