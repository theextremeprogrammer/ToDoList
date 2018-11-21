import UIKit

final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // MARK: - Injected Dependencies
    var http: Http
    var router: Router?
    
    // MARK: - Initialization
    
    // This convenience initializer is called first when running the app and creates
    //      our dependencies to inject them into the init(...) method.
    convenience override init() {
        let http = NetworkHttp(networkSession: URLSession.shared)
        
        self.init(http: http)
    }

    // This initializer can be called from tests for the purpose of testing the app delegate.
    init(http: Http,
         router: Router? = nil
    ) {
        self.http = http
        self.router = router
    }
    
    // MARK: - UIApplicationDelegate
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        router?.showToDoListViewController()
        
        let toDoListRepo = NetworkToDoListRepository(http: http)

        let rootViewController = ToDoListViewController(
            toDoListRepo: toDoListRepo,
            reloader: DefaultReloader()
        )

        let navigationController = UINavigationController(
            rootViewController: rootViewController
        )

        window = UIWindow()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}
