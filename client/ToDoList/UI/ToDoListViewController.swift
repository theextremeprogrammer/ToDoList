import UIKit
import PureLayout

class ToDoListViewController: UIViewController {
    // MARK: - Injected Properties
    private var toDoListRepo: ToDoListRepository
    private var reloader: Reloader
    
    // MARK: - Properties
    private var didSetupConstraints: Bool = false
    private var toDoItems: [ToDoItem] = []

    // MARK: - View Elements
    private var tableView: UITableView!

    // MARK: - Initializers
    init(
        toDoListRepo: ToDoListRepository,
        reloader: Reloader
    ) {
        self.toDoListRepo = toDoListRepo
        self.reloader = reloader
        
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
        
        toDoListRepo
            .getAll()
            .onSuccess { toDoItems in
                self.toDoItems = toDoItems
                self.reloader.reload(reloadable: self.tableView)
            }
    }

    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            tableView.autoPinEdgesToSuperviewSafeArea()

            didSetupConstraints = true
        }

        super.updateViewConstraints()
    }
}

// MARK: - View Setup
fileprivate extension ToDoListViewController {
    func initializeViews() {
        tableView = UITableView(frame: CGRect.zero)
    }

    func configureNavigationBar() {
        title = "To Do List"
    }

    func addSubviews() {
        view.addSubview(tableView)
    }

    func configureSubviews() {
        view.backgroundColor = UIColor.white

        tableView.backgroundColor = UIColor.clear
        tableView.dataSource = self
        
        // When registering the types of cells for a UITableView, as a general practice I
        //      prefer to use String(describing: <classname>.self) in order to avoid any
        //      possible fat-fingering of names. This keeps the cell identifier in sync
        //      with the call class name as well.
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: String(describing: UITableViewCell.self)
        )
    }
}

// MARK: - UITableViewDataSource
extension ToDoListViewController: UITableViewDataSource {
    // While this method implementation is optional, similar to how I do not appreciate
    //      Spring's "auto-configuration", I prefer to make this explicit.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // There are various benefits and drawbacks of using a UITableView. This is the quickest
    //      way to get up and running with a list, but as with everything you should weight
    //      the pros and cons based on your needs and choose the appropriate implementation.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)

        cell.textLabel?.text = toDoItems[indexPath.row].title

        return cell
    }
}
