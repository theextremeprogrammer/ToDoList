@testable import ToDoList

final class DummyReloader: Reloader {
    func reload(reloadable: Reloadable) {
        assertionFailure("reload() - not expected to have been called")
    }
}
