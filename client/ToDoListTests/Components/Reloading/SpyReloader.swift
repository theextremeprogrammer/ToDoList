@testable import ToDoList

class SpyReloader: Reloader {
    private(set) var reload_argument_reloadable: Reloadable? = nil
    func reload(reloadable: Reloadable) {
        reload_argument_reloadable = reloadable
    }
}
