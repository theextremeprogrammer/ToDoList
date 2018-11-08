import BrightFutures

protocol ToDoListRepository {
    func getAll() -> Future<[ToDoItem], RepoError>
}
