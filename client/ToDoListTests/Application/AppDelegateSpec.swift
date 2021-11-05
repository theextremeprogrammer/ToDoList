import Quick
import Nimble
import Succinct
import UIKit
@testable import ToDoList

class AppDelegateSpec: QuickSpec {
    override func spec() {
        describe("the appliation delegate") {
            describe("when the application launches") {
                var spyRouter: SpyRouter!
                
                beforeEach {
                    spyRouter = SpyRouter()
                    let appDelegate = AppDelegate(router: spyRouter)
                    
                    
                    let _ = appDelegate.application(
                        UIApplication.shared,
                        didFinishLaunchingWithOptions: nil
                    )
                }
                
                it("navigates to the to do list view controller") {
                    expect(spyRouter.showToDoListViewController_wasCalled).to(beTrue())
                }
            }
        }
    }
}
