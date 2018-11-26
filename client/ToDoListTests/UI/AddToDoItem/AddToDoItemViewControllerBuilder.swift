@testable import ToDoList

final class AddToDoItemViewControllerBuilder {
    private var router: Router = DummyRouter()
    private var toDoListRepo: ToDoListRepository = DummyToDoListRepository()

    func withRouter(_ router: Router) -> AddToDoItemViewControllerBuilder {
        self.router = router
        return self
    }

    func withToDoListRepo(_ toDoListRepo: ToDoListRepository) -> AddToDoItemViewControllerBuilder {
        self.toDoListRepo = toDoListRepo
        return self
    }

    func build() -> AddToDoItemViewController {
        return AddToDoItemViewController(
            router: router,
            toDoListRepository: toDoListRepo
        )
    }
}
