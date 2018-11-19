import UIKit

final class TestingAppDelegate: UIApplication, UIApplicationDelegate {}

func executingTests() -> Bool {
    // If we can create an instance of the XCTestCase class then it means that we are
    //      executing our application within a test target.
    return NSClassFromString("XCTestCase") != nil
}

func launchApplication(withDelegateClassName delegateClassName: String) {
    let _ = UIApplicationMain(
        CommandLine.argc,
        CommandLine.unsafeArgv,
        NSStringFromClass(UIApplication.self),
        delegateClassName
    )
}

if executingTests() {
    launchApplication(withDelegateClassName: NSStringFromClass(TestingAppDelegate.self))
} else {
    launchApplication(withDelegateClassName: NSStringFromClass(AppDelegate.self))
}
