@testable import ToDoList

final class SpyToDoListRepo: ToDoListRepository {
    func getAll() -> AsyncReturnValue<[ToDoItem], RepoError> {
        return AsyncReturnValue()
    }
    
    private(set) var create_argument_newToDo: NewToDoItem? = nil
    func create(newToDo: NewToDoItem) -> AsyncReturnValue<ToDoItem, RepoError> {
        create_argument_newToDo = newToDo
        return AsyncReturnValue()
    }
}
