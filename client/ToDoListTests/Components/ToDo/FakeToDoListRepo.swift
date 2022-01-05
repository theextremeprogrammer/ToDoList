@testable import ToDoList

final class FakeToDoListRepo: ToDoListRepository {
    func getAll() -> AsyncReturnValue<[ToDoItem], RepoError> {
        return AsyncReturnValue()
    }
    
    func create(newToDo: NewToDoItem) -> AsyncReturnValue<ToDoItem, RepoError> {
        let toDoItem = ToDoItemBuilder()
            .withId(1)
            .withTitle(newToDo.title)
            .withCompleted(false)
            .build()
        
        return AsyncReturnValue(value: toDoItem)
    }
}
