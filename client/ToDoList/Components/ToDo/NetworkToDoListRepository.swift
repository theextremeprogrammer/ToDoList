import Foundation
import BrightFutures

protocol ToDoListRepository {
    func getAll() -> Future<[ToDoItem], RepoError>
}

struct NetworkToDoListRepository: ToDoListRepository {
    let http: Http
    
    // Note the custom initializer here which takes an optional Http object and initializes the value to nil if one is not passed in. This is done on purpose to allow us to focus on the one test that we are writing without having an impact on a) other tests which may utilize this object as well as the callers in the implementation of this object. We can remove the optional from this as well as the nil initializer to force us to implement this in other areas after we are finished with the current testing approach. 
    init(http: Http) {
        self.http = http
    }
    
    func getAll() -> Future<[ToDoItem], RepoError> {
        // Our http component returns a future so one way to implement this is to simply use the BrightFutures map() implementation to convert the result of one future to the result of another future. However, since an error could also occur, we also need to map the error from the HttpError type to the RepoError type. Since there is no test for this yet (we can't compile the code until we return something), a temporary value of "undefined" is returned.
        
        // Since our Http object here is optional this implementation allows our Repo tests to pass - however the AppDelegate test fails because we are not passing in an Http object. 
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
