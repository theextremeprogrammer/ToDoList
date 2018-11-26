import UIKit

final class AddToDoItemViewController: UIViewController {
    // MARK: - Injected Properties
    private var router: Router
    private var toDoListRepo: ToDoListRepository
    
    // MARK: - Properties
    private var didSetupConstraints: Bool = false
    
    // MARK: - Views
    private var titleTextField: UITextField!
    
    // MARK: - Initialization
    init(router: Router,
         toDoListRepository: ToDoListRepository
    ) {
        self.router = router
        self.toDoListRepo = toDoListRepository
        
        super.init(nibName: nil, bundle: nil)
        
        view.setNeedsUpdateConstraints()
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
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            titleTextField.autoPinEdge(toSuperviewSafeArea: .top, withInset: 15.0)
            titleTextField.autoPinEdge(toSuperviewEdge: .left, withInset: 15.0)
            titleTextField.autoPinEdge(toSuperviewEdge: .right, withInset: 15.0)

            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
}

// MARK: - View Setup
fileprivate extension AddToDoItemViewController {
    func initializeViews() {
        titleTextField = UITextField.newAutoLayout()
    }
    
    func configureNavigationBar() {
        title = "Add To Do Item"
        
        titleTextField.placeholder = "Edit blog post"

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .stop,
            target: self,
            action: #selector(didTapCancelBarButtonItem)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDoneBarButtonItem)
        )
    }
    
    func addSubviews() {
        view.addSubview(titleTextField)
    }
    
    func configureSubviews() {
        view.backgroundColor = .white
        
        titleTextField.borderStyle = .line
    }
}

fileprivate extension AddToDoItemViewController {
    @objc func didTapCancelBarButtonItem(_ sender: UIBarButtonItem) {
        router.dismissModalVC()
    }
    
    @objc func didTapDoneBarButtonItem(_ sender: UIBarButtonItem) {
        let newToDo = NewToDoItemBuilder()
            .withTitle(titleTextField.text!)
            .build()

        let _ = toDoListRepo.create(newToDo: newToDo)
        
        router.dismissModalVC()
    }
}
