import BrightFutures

protocol ToDoListRepository {
    func getAll() -> Future<[ToDoItem], RepoError>
}

struct NetworkToDoListRepository: ToDoListRepository {
    let http: Http?
    
    // Note the custom initializer here which takes an optional Http object and initializes the value to nil if one is not passed in. This is done on purpose to allow us to focus on the one test that we are writing without having an impact on a) other tests which may utilize this object as well as the callers in the implementation of this object. We can remove the optional from this as well as the nil initializer to force us to implement this in other areas after we are finished with the current testing approach. 
    init(http: Http? = nil) {
        self.http = http
    }
    
    func getAll() -> Future<[ToDoItem], RepoError> {
        let _ = http?.get(url: "http://localhost:8080/todolist")
        
        return Future { getAllToDoListItemsFutureComplete in
            getAllToDoListItemsFutureComplete(
                .success([
                    ToDoItem(title: "Get groceries"),
                    ToDoItem(title: "Pick up dry cleaning")
                ])
            )
        }
    }
}
