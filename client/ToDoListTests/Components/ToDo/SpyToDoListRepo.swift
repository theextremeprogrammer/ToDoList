import BrightFutures
@testable import ToDoList

final class SpyToDoListRepo: ToDoListRepository {
    func getAll() -> Future<[ToDoItem], RepoError> {
        return Future()
    }
    
    private(set) var create_argument_newToDo: NewToDoItem? = nil
    func create(newToDo: NewToDoItem) {
        create_argument_newToDo = newToDo
    }
}
