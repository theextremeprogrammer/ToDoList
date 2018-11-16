import Quick
import Nimble
@testable import ToDoList

class DefaultReloaderSpec: QuickSpec {
    override func spec() {
        describe("default reloader") {
            it("calls reload on the object that is passed in") {
                let spyReloadable = SpyReloadable()

                
                let defaultReloader = DefaultReloader()
                defaultReloader.reload(reloadable: spyReloadable)
                
                
                expect(spyReloadable.reloadData_wasCalled).to(beTrue())
            }
        }
    }
}
