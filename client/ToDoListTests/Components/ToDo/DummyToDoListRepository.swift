@testable import ToDoList

final class DummyToDoListRepository: ToDoListRepository {
    func getAll() async throws -> [ToDoItem] {
        assertionFailure("getAll() - not expected to have been called")
        return []
    }
    
    func create(newToDo: NewToDoItem) async throws -> ToDoItem {
        assertionFailure("create() - not expected to have been called")
        return ToDoItem(id: -1, title: "", completed: false)
    }
}
