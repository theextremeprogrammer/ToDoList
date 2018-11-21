import UIKit

final class AddToDoItemViewController: UIViewController {
    // MARK: - Properties
    private var router: Router?
    
    // MARK: - Initialization
    init(router: Router? = nil) {
        self.router = router
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(didTapCancelBarButtonItem)
        )
    }
}

fileprivate extension AddToDoItemViewController {
    @objc func didTapCancelBarButtonItem(_ sender: UIBarButtonItem) {
        router?.dismissModalVC()
    }
}
