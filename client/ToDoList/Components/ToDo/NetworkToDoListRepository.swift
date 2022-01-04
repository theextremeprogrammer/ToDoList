import Foundation

// As a general practice, unless there are multiple objects which are implementing a
//      single protocol, the protocol definition is maintained in the same file as the
//      implementation that uses it.
//
// While the protocol and implementation definitions can be split into different files,
//      when accessing method definitions of an object (for a protocol), Xcode will
//      always navigate to the protocol definition and not the implementation. By
//      co-locating these in the same file it makes it a bit easier to get around.
protocol ToDoListRepository {
    func getAll() async throws -> [ToDoItem]
    func create(newToDo: NewToDoItem) async throws -> ToDoItem
}

struct NetworkToDoListRepository: ToDoListRepository {
    let http: Http
    
    init(http: Http) {
        self.http = http
    }
    
    func getAll() async throws -> [ToDoItem] {
        // This branch uses async/await to implement this, so the code can read as if it is synchronous - please note
        //      however that the next line with `await` will wait for the function to complete before continuing.
        let data = try await http.get(endpoint: "/todos")
        
        // try! would be replaced here with proper error handling in case the response cannot be parsed
        //      (driven by tests, of course)
        let toDoItems = try! JSONDecoder().decode([ToDoItem].self, from: data)
        return toDoItems
    }
    
    func create(newToDo: NewToDoItem) async throws -> ToDoItem {
        // Lots of exclamation points here. For each exclamation point, at some time
        //      in the future, these should be replaced with appropriate error
        //      handling for when something goes wrong to ensure that this renders
        //      properly for the end-user.
        let jsonData = try! JSONEncoder().encode(newToDo)

        let data = try await http
            .post(
                endpoint: "/todos",
                requestBody: jsonData
            )
        let toDoItem = try! JSONDecoder().decode(ToDoItem.self, from: data)
        return toDoItem
    }
}
