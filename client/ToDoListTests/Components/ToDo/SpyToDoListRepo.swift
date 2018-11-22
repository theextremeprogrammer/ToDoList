import BrightFutures
@testable import ToDoList

final class SpyToDoListRepo: ToDoListRepository {
    func getAll() -> Future<[ToDoItem], RepoError> {
        return Future()
    }
    
    private(set) var create_argument_newToDo: NewToDo? = nil
    func create(newToDo: NewToDo) {
        create_argument_newToDo = newToDo
    }
}
