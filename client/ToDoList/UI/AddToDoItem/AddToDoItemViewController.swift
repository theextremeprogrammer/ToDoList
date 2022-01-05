import UIKit

protocol AddToDoItemDelegate: AnyObject {
    func add(toDoItem: ToDoItem)
}

final class AddToDoItemViewController: UIViewController {
    // MARK: - Injected Properties
    private var router: Router
    private var toDoListRepo: ToDoListRepository
    
    // MARK: - Properties
    private var didSetupConstraints: Bool = false
    weak var delegate: AddToDoItemDelegate? = nil

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
        title = i18n.AddToDoItem.title.value
        
        titleTextField.placeholder = i18n.AddToDoItem.newToDoTitlePlaceholder.value

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

        let _ = toDoListRepo
            .create(newToDo: newToDo)
            .done { toDoItem in
                self.delegate?.add(toDoItem: toDoItem)
                self.router.dismissModalVC()
            }
            .catch { _ in }
    }
}
