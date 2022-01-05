@testable import ToDoList

class StubToDoListRepository: ToDoListRepository {
    private(set) var getAll_returnPromise = AsyncPromise<[ToDoItem], RepoError>()
    func getAll() -> AsyncReturnValue<[ToDoItem], RepoError> {
        // If this Stub Repository is being used then we should always expect to get
        //      something back from it, and if not it's OK for this to complain. 
        return getAll_returnPromise.future
    }

    
    
    private(set) var create_returnPromise = AsyncPromise<ToDoItem, RepoError>()
    func create(newToDo: NewToDoItem) -> AsyncReturnValue<ToDoItem, RepoError> {
        return create_returnPromise.future
    }
}
