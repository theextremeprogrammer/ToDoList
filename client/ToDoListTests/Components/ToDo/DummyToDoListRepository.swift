@testable import ToDoList

final class DummyToDoListRepository: ToDoListRepository {
    func getAll() -> AsyncReturnValue<[ToDoItem], RepoError> {
        assertionFailure("getAll() - not expected to have been called")
        return AsyncReturnValue()
    }
    
    func create(newToDo: NewToDoItem) -> AsyncReturnValue<ToDoItem, RepoError> {
        assertionFailure("create() - not expected to have been called")
        return AsyncReturnValue()
    }
}
