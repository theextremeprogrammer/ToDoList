import Quick
import Nimble
@testable import ToDoList

class DefaultReloaderSpec: QuickSpec {
    override func spec() {
        var defaultReloader: DefaultReloader!

        describe("default reloader") {
            beforeEach {
                defaultReloader = DefaultReloader()
            }

            it("calls reload on the object that is passed in") {
                let spyReloadable = SpyReloadable()
                defaultReloader.reload(reloadable: spyReloadable)
                
                
                expect(spyReloadable.reloadData_wasCalled).to(beTrue())
            }
        }
    }
}
