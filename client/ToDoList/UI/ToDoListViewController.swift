import UIKit
import PureLayout

class ToDoListViewController: UIViewController {
    // MARK: - Properties
    private var didSetupConstraints: Bool = false
    private let toDoItems: [ToDoItem]

    // MARK: - View Elements
    private var tableView: UITableView!

    // MARK: - Initializers
    init() {
        toDoItems = [
            ToDoItem(title: "Get groceries"),
            ToDoItem(title: "Pick up dry cleaning")
        ]

        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = UIColor.white
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
        tableView.dataSource = self
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: String(describing: UITableViewCell.self)
        )
        tableView.backgroundColor = UIColor.clear
    }
}

// MARK: - UITableViewDataSource
extension ToDoListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)

        cell.textLabel?.text = toDoItems[indexPath.row].title

        return cell
    }
}
