@testable import ToDoList

final class SpyToDoListRepo: ToDoListRepository {
    func getAll() async throws -> [ToDoItem] {
        return []
    }

//    private(set) var create_argument_newToDo: NewToDoItem? = nil
//    func create(newToDo: NewToDoItem) -> Future<ToDoItem, RepoError> {
//        create_argument_newToDo = newToDo
//        return Future()
//    }
}
