import Quick
import Nimble
import Succinct
@testable import ToDoList

class AppDelegateSpec: QuickSpec {
    override func spec() {
        describe("the appliation delegate") {
            describe("when the application launches") {
                var spyRouter: SpyRouter!
                
                beforeEach {
                    spyRouter = SpyRouter()
                    
                    let appDelegate = AppDelegate(
                        http: SpyHttp(),
                        router: spyRouter
                    )
                    
                    
                    let _ = appDelegate.application(
                        UIApplication.shared,
                        didFinishLaunchingWithOptions: nil
                    )
                }
                
                it("navigates to the to do list view controller") {
                    expect(spyRouter.showToDoListViewController_wasCalled).to(beTrue())
                }

                it("uses a navigation controller") {
                    let rootViewController = UIApplication.shared.keyWindow?.rootViewController
                    expect(rootViewController).toEventually(beAKindOf(UINavigationController.self))
                }
                
                it("displays the to do list view controller") {
                    let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
                    let topViewController = navigationController?.topViewController
                    expect(topViewController).toEventually(beAKindOf(ToDoListViewController.self))
                }
            }
        }
    }
}
