import UIKit

final class AddToDoItemViewController: UIViewController {
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeViews()
        configureNavigationBar()
        addSubviews()
        configureSubviews()
    }
}

// MARK: - View Setup
fileprivate extension AddToDoItemViewController {
    func initializeViews() {
    }
    
    func configureNavigationBar() {
        title = "Add To Do Item"
    }
    
    func addSubviews() {
    }
    
    func configureSubviews() {
    }
}
