import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    // MARK: - Injected Dependencies
    var router: Router

    // MARK: - Initialization
    // This convenience initializer is called first when running the app and creates
    //      our dependencies to inject them into the init(...) method.
    convenience override init() {
        let http = NetworkHttp(
            baseUrl: Configuration.environment.baseURL,
            networkSession: URLSession.shared
        )

        let toDoListRepo = NetworkToDoListRepository(http: http)

        let router = NavigationRouter(
            navigationController: UINavigationController(),
            toDoListRepo: toDoListRepo,
            animated: true
        )
        self.init(router: router)
    }

    // This initializer can be called from tests for the purpose of testing the app delegate.
    init(router: Router) {
        self.router = router
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        debugPrint(#function)

        guard let windowScene = (scene as? UIWindowScene) else { return }

        router.showToDoListViewController()

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = router.navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        debugPrint(#function)
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        debugPrint(#function)
    }

    func sceneWillResignActive(_ scene: UIScene) {
        debugPrint(#function)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        debugPrint(#function)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        debugPrint(#function)
    }
}
