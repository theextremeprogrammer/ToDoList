import BrightFutures
@testable import ToDoList

class StubToDoListRepository: ToDoListRepository {
    var getAll_returnValue: Future<[ToDoItem], RepoError>? = nil
    func getAll() -> Future<[ToDoItem], RepoError> {
        // If this Stub Repository is being used then we should always expect to get
        //      something back from it, and if not it's OK for this to complain. 
        return getAll_returnValue!
    }

    func create(newToDo: NewToDoItem) -> Future<ToDoItem, RepoError> {
        return Future()
    }
}
