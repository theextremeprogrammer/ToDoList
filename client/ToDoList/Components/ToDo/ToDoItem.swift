struct ToDoItem: Codable {
    let id: Int
    let title: String
    let completed: Bool
}

extension ToDoItem: Equatable {}

func ==(lhs: ToDoItem, rhs: ToDoItem) -> Bool {
    return
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.completed == rhs.completed
}
