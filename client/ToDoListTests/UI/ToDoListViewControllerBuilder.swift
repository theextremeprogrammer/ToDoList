@testable import ToDoList

final class ToDoListViewControllerBuilder {
    private var toDoListRepo: ToDoListRepository = StubToDoListRepository()
    private var router: Router = DummyRouter()
    private var reloader: Reloader = DummyReloader()

    func withToDoListRepo(_ toDoListRepo: ToDoListRepository) -> ToDoListViewControllerBuilder {
        self.toDoListRepo = toDoListRepo
        return self
    }

    func withRouter(_ router: Router) -> ToDoListViewControllerBuilder {
        self.router = router
        return self
    }
    
    func withReloader(_ reloader: Reloader) -> ToDoListViewControllerBuilder {
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
