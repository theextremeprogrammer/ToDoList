@testable import ToDoList

final class FakeToDoListRepo: ToDoListRepository {
    func getAll() -> AsyncReturnValue<[ToDoItem]> {
        return AsyncReturnValue.pending().promise
    }
    
    func create(newToDo: NewToDoItem) -> AsyncReturnValue<ToDoItem> {
        let toDoItem = ToDoItemBuilder()
            .withId(1)
            .withTitle(newToDo.title)
            .withCompleted(false)
            .build()
        
        return AsyncReturnValue.value(toDoItem)
    }
}
