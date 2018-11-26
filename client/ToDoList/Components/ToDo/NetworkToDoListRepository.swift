import Foundation
import BrightFutures

// As a general practice, unless there are multiple objects which are implementing a
//      single protocol, the protocol definition is maintained in the same file as the
//      implementation that uses it.
//
// While the protocol and implementation definitions can be split into different files,
//      when accessing method definitions of an object (for a protocol), Xcode will
//      always navigate to the protocol definition and not the implementation. By
//      co-locating these in the same file it makes it a bit easier to get around.
protocol ToDoListRepository {
    func getAll() -> Future<[ToDoItem], RepoError>
    func create(newToDo: NewToDoItem) -> Future<ToDoItem, RepoError>
}

struct NetworkToDoListRepository: ToDoListRepository {
    let http: Http
    
    init(http: Http) {
        self.http = http
    }
    
    func getAll() -> Future<[ToDoItem], RepoError> {
        // Our http component returns a future so one way to implement this is to simply
        //      use the BrightFutures map() implementation to convert the result of one
        //      future to the result of another future. However, since an error could also
        //      occur, we also need to map the error from the HttpError type to the
        //      RepoError type. Since there is no test for this yet a temporary value of
        //      "undefined" is returned. Due to Swift's type system - we can't even
        //      compile the code until we return something, so this must be added (for
        //      better or for worse).
        return http
            .get(url: "http://localhost:8080/todos")
            .map { data in
                let decoder = JSONDecoder()
                let toDoItems = try! decoder.decode([ToDoItem].self, from: data)
                return toDoItems
            }
            .mapError { httpError in
                return RepoError.undefined
            }
    }
    
    func create(newToDo: NewToDoItem) -> Future<ToDoItem, RepoError> {
        // Lots of exclamation points here. For each exclamation point, at some time
        //      in the future, these should be replaced with appropriate error
        //      handling for when something goes wrong to ensure that this renders
        //      properly for the end-user.
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(newToDo)
        
        return http
            .post(
                url: "http://localhost:8080/todos",
                requestBody: jsonData
            )
            .map { data in
                let decoder = JSONDecoder()
                let toDoItem = try! decoder.decode(ToDoItem.self, from: data)
                return toDoItem
            }
            .mapError { httpError in
                return RepoError.undefined
            }
    }
}
