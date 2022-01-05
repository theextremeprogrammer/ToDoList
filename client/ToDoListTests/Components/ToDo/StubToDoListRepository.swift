@testable import ToDoList

class StubToDoListRepository: ToDoListRepository {
    private(set) var ( getAll_returnPromise, getAll_returnResolver ) = AsyncReturnValue<[ToDoItem]>.pending()
    func getAll() -> AsyncReturnValue<[ToDoItem]> {
        // If this Stub Repository is being used then we should always expect to get
        //      something back from it, and if not it's OK for this to complain. 
        return getAll_returnPromise
    }

    
    
    private(set) var ( create_returnPromise, create_returnResolver ) = AsyncReturnValue<ToDoItem>.pending()
    func create(newToDo: NewToDoItem) -> AsyncReturnValue<ToDoItem> {
        return create_returnPromise
    }
}
