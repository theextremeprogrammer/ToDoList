import UIKit

final class TestingAppDelegate: UIApplication, UIApplicationDelegate {}

if NSClassFromString("XCTestCase") != nil {
    let _ = UIApplicationMain(
        CommandLine.argc,
        CommandLine.unsafeArgv,
        NSStringFromClass(UIApplication.self),
        NSStringFromClass(TestingAppDelegate.self)
    )
} else {
    let _ = UIApplicationMain(
        CommandLine.argc,
        CommandLine.unsafeArgv,
        NSStringFromClass(UIApplication.self),
        NSStringFromClass(AppDelegate.self)
    )
}
