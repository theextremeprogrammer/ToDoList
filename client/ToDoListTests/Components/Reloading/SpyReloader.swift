@testable import ToDoList

class SpyReloader: Reloader {
    // When spying on objects as a general practice they are defined as optional and
    //      initialized to nil to ensure that they are only set explicitly.
    private(set) var reload_argument_reloadable: Reloadable? = nil
    func reload(reloadable: Reloadable) {
        reload_argument_reloadable = reloadable
    }
}
