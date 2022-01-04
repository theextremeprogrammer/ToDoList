@testable import ToDoList

final class FakeToDoListRepo: ToDoListRepository {
    func getAll() async throws -> [ToDoItem] {
        return []
    }
    
    func create(newToDo: NewToDoItem) async throws -> ToDoItem {
        let toDoItem = ToDoItemBuilder()
            .withId(1)
            .withTitle(newToDo.title)
            .withCompleted(false)
            .build()
        
        return toDoItem
    }
}
