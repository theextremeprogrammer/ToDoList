import Foundation
import BrightFutures

// As a general practice, unless there are multiple objects which are implementing a
//      single protocol, I tend to keep the protocol definition in the same file as the
//      implementation that uses it.
//
// Originally I preferred to split out the protocol and implementation definitions - however
//      I found that when trying to access method definitions of a protocol Xcode would
//      always navigate to the protocol definition and not the implementation. By co-locating
//      these in the same file it makes it a bit easier to get around.
protocol ToDoListRepository {
    func getAll() -> Future<[ToDoItem], RepoError>
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
            .get(url: "http://localhost:8080/todolist")
            .map { data in
                let decoder = JSONDecoder()
                let toDoItems = try! decoder.decode([ToDoItem].self, from: data)
                return toDoItems
            }
            .mapError { httpError in
                return RepoError.undefined
            }
    }
}
