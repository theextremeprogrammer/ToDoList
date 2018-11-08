import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        let rootViewController = ToDoListViewController()
        
        window = UIWindow()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}
