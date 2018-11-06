import Quick
import Nimble
import Succinct
@testable import ToDoList

class ToDoListTests: QuickSpec {
    override func spec() {
        describe("wiring test") {
            it("works") {
                let twelve = 12
                
                
                expect(twelve).to(equal(12))
            }
            
            it("can call Succinct methods too") {
                let maybeObject: String? = nil
                
                
                expect(maybeObject.isNil()).to(beTrue())
            }
        }
    }
}
