@testable import ToDoList

class StubToDoListRepository: ToDoListRepository {
    var getAll_returnValue: [ToDoItem] = []
    func getAll() async throws -> [ToDoItem] {
        // If this Stub Repository is being used then we should always expect to get
        //      something back from it, and if not it's OK for this to complain.
        return getAll_returnValue
    }

    var create_returnValue: ToDoItem? = nil
    func create(newToDo: NewToDoItem) async throws -> ToDoItem {
        return create_returnValue!
    }
}
