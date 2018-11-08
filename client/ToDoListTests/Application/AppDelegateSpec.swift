import Quick
import Nimble
import Succinct
@testable import ToDoList

class AppDelegateSpec: QuickSpec {
    override func spec() {
        describe("the appliation delegate") {
            it("displays the to do list view conotroller upon launch") {
                let appDelegate = AppDelegate()
                let _ = appDelegate.application(
                    UIApplication.shared,
                    didFinishLaunchingWithOptions: nil
                )
                
                
                let rootViewController = UIApplication.shared.keyWindow?.rootViewController
                expect(rootViewController).to(beAKindOf(ToDoListViewController.self))
            }
        }
    }
}
