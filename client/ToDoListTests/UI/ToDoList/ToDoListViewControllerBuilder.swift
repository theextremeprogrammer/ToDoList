@testable import ToDoList

final class ToDoListViewControllerBuilder {
    private var toDoListRepo: ToDoListRepository = StubToDoListRepository()
    private var router: Router = DummyRouter()
    private var reloader: Reloader = DummyReloader()

    func withToDoListRepo(_ toDoListRepo: ToDoListRepository) -> Self {
        self.toDoListRepo = toDoListRepo
        return self
    }

    func withRouter(_ router: Router) -> Self {
        self.router = router
        return self
    }

    func withReloader(_ reloader: Reloader) -> Self {
        self.reloader = reloader
        return self
    }

    func build() -> ToDoListViewController {
        return ToDoListViewController(
            toDoListRepo: toDoListRepo,
            router: router,
            reloader: reloader
        )
    }
}
