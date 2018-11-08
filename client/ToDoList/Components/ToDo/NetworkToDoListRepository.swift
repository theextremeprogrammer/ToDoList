import BrightFutures

protocol ToDoListRepository {
    func getAll() -> Future<[ToDoItem], RepoError>
}

struct NetworkToDoListRepository: ToDoListRepository {
    func getAll() -> Future<[ToDoItem], RepoError> {
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
