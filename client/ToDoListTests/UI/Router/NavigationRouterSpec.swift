import Quick
import Nimble
import UIKit
@testable import ToDoList

final class NavigationRouterSpec: QuickSpec {
    override func spec() {
        var navRouter: NavigationRouter!

        var window: UIWindow?
        var rootNavController: UINavigationController!
        let animated: Bool = false
        
        beforeEach {
            rootNavController = UINavigationController()
            navRouter = NavigationRouter(
                navigationController: rootNavController,
                toDoListRepo: StubToDoListRepository(),
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

            describe("showing the add to do item view controller") {
                var spyAddToDoItemDelegate: SpyAddToDoItemDelegate!

                beforeEach {
                    instantiateUIWindowForUnitTesting(rootViewController: rootNavController)
                    spyAddToDoItemDelegate = SpyAddToDoItemDelegate()


                    navRouter.showAddToDoItemViewController(delegate: spyAddToDoItemDelegate)
                }

                it("displays as a modal") {
                    let presentedNavVC = rootNavController.presentedViewController as? UINavigationController
                    let presentedVC = presentedNavVC?.topViewController
                    expect(presentedVC).toEventually(beAKindOf(AddToDoItemViewController.self))
                }

                it("sets the delegate to the passed in object") {
                    let presentedNavVC = rootNavController.presentedViewController as? UINavigationController
                    let addToDoItemVC = presentedNavVC?.topViewController as? AddToDoItemViewController
                    expect(addToDoItemVC?.delegate).to(be(spyAddToDoItemDelegate))
                }
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
