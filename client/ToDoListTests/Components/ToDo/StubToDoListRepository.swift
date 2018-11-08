import BrightFutures
@testable import ToDoList

class StubToDoListRepository: ToDoListRepository {
    var getAll_returnValue: Future<[ToDoItem], RepoError>? = nil
    func getAll() -> Future<[ToDoItem], RepoError> {
        return getAll_returnValue!
    }
}
