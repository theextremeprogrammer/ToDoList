@testable import ToDoList

final class DummyToDoListRepository: ToDoListRepository {
    func getAll() -> AsyncReturnValue<[ToDoItem]> {
        assertionFailure("getAll() - not expected to have been called")
        return AsyncReturnValue.pending().promise
    }
    
    func create(newToDo: NewToDoItem) -> AsyncReturnValue<ToDoItem> {
        assertionFailure("create() - not expected to have been called")
        return AsyncReturnValue.pending().promise
    }
}
