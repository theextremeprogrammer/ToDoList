import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // MARK: - Injected Dependencies
    var http: Http
    
    // MARK: - Initialization
    init(http: Http) {
        self.http = http
    }
    
    // MARK: - UIApplicationDelegate
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        let toDoListRepo = NetworkToDoListRepository(http: http)
        let rootViewController = ToDoListViewController(toDoListRepo: toDoListRepo)
        
        window = UIWindow()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}
