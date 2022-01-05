@testable import ToDoList

final class SpyToDoListRepo: ToDoListRepository {
    func getAll() -> AsyncReturnValue<[ToDoItem]> {
        return AsyncReturnValue<[ToDoItem]>.pending().promise
    }
    
    private(set) var create_argument_newToDo: NewToDoItem? = nil
    func create(newToDo: NewToDoItem) -> AsyncReturnValue<ToDoItem> {
        create_argument_newToDo = newToDo
        return AsyncReturnValue<ToDoItem>.pending().promise
    }
}
