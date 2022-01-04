@testable import ToDoList

final class SpyToDoListRepo: ToDoListRepository {
    func getAll() async throws -> [ToDoItem] {
        return []
    }

    private(set) var create_argument_newToDo: NewToDoItem? = nil
    func create(newToDo: NewToDoItem) async throws -> ToDoItem {
        create_argument_newToDo = newToDo
        return ToDoItem(id: -1, title: "", completed: false)
    }
}
