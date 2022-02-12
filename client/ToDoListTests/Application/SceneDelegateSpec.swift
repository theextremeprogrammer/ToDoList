import Quick
import Nimble
import Succinct
import UIKit
@testable import ToDoList

class SceneDelegateSpec: QuickSpec {
    override func spec() {
        xdescribe("the scene delegate") {
            describe("when the application launches") {
                var spyRouter: SpyRouter!
                
                beforeEach {
                    spyRouter = SpyRouter()
                    let sceneDelegate = SceneDelegate(router: spyRouter)
                    

                    // TODO: Instantiate objects needed to test the SceneDelegate
                    //       https://qualitycoding.org/unit-test-scene-delegates/
                    //let _ = sceneDelegate.scene(
                    //    UIWindowScene(),
                    //    willConnectTo: UISceneSession(),
                    //    options: UIScene.ConnectionOptions()
                    //)
                }
                
                it("navigates to the to do list view controller") {
                    expect(spyRouter.showToDoListViewController_wasCalled).to(beTrue())
                }
            }
        }
    }
}
