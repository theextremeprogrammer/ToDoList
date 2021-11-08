import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
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
    
    // MARK: - UIApplicationDelegate
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        router.showToDoListViewController()

        window = UIWindow()
        window?.rootViewController = router.navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}
