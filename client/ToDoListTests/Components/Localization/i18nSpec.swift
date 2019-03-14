import Quick
import Nimble
@testable import ToDoList

class i18Spec: QuickSpec {
    override func spec() {
        describe("internationalization") {
            describe("how strings are translated") {
                it("shows how NSLocalizedString translates a code to a value") {
                    let localizedStringKey = "ADDTODOITEM_TITLE"


                    let localizedString = NSLocalizedString(localizedStringKey, comment: "")


                    expect(localizedString).to(equal("Add To Do Item"))
                }
            }

            describe("how the i18n object helps us to translate strings") {
                it("translates an i18n key into the expected localized string key") {
                    expect(i18n.AddToDoItem.title.localizedStringKey).to(equal("ADDTODOITEM_TITLE"))
                }

                it("translates an i18n key into the expected localized string value") {
                    expect(i18n.AddToDoItem.title.value).to(equal("Add To Do Item"))
                }
            }
        }    }
}
