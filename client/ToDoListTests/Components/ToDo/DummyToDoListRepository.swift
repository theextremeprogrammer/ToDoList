@testable import ToDoList

final class DummyToDoListRepository: ToDoListRepository {
    func getAll() async throws -> [ToDoItem] {
        //        assertionFailure("getAll() - not expected to have been called")
        //        return Future()
        return []
    }
    
//    func create(newToDo: NewToDoItem) -> Future<ToDoItem, RepoError> {
//        assertionFailure("create() - not expected to have been called")
//        return Future()
//    }
}
