@testable import ToDoList

final class AddToDoItemViewControllerBuilder {
    private var router: Router = DummyRouter()
    private var toDoListRepo: ToDoListRepository = DummyToDoListRepository()
    private var delegate: AddToDoItemDelegate? = nil

    func withRouter(_ router: Router) -> AddToDoItemViewControllerBuilder {
        self.router = router
        return self
    }

    func withToDoListRepo(_ toDoListRepo: ToDoListRepository) -> AddToDoItemViewControllerBuilder {
        self.toDoListRepo = toDoListRepo
        return self
    }

    func withDelegate(_ delegate: AddToDoItemDelegate) -> AddToDoItemViewControllerBuilder {
        self.delegate = delegate
        return self
    }
    
    func build() -> AddToDoItemViewController {
        return AddToDoItemViewController(
            router: router,
            toDoListRepository: toDoListRepo,
            delegate: delegate
        )
    }
}
