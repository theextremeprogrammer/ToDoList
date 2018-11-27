@testable import ToDoList

final class SpyAddToDoItemDelegate: AddToDoItemDelegate {
    private(set) var add_argument_toDoItem: ToDoItem? = nil
    func add(toDoItem: ToDoItem) {
        add_argument_toDoItem = toDoItem
    }
}
