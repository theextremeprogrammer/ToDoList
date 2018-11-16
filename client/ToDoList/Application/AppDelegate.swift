import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // MARK: - Injected Dependencies
    var http: Http
    
    // MARK: - Initialization
    convenience override init() {
        let http = NetworkHttp(networkSession: URLSession.shared)
        
        self.init(http: http)
    }
    
    init(http: Http) {
        self.http = http
    }
    
    // MARK: - UIApplicationDelegate
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        let toDoListRepo = NetworkToDoListRepository(http: http)
        let rootViewController = ToDoListViewController(
            toDoListRepo: toDoListRepo,
            reloader: DefaultReloader()
        )
        
        window = UIWindow()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}
