struct ToDoItem: Codable {
    let id: Int
    let title: String
    let completed: Bool
}

extension ToDoItem: Equatable {
    static func ==(lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.completed == rhs.completed
    }
}

final class ToDoItemBuilder {
    private var id: Int = -1
    private var title: String = ""
    private var completed: Bool = false

    func withId(_ id: Int) -> ToDoItemBuilder {
        self.id = id
        return self
    }

    func withTitle(_ title: String) -> ToDoItemBuilder {
        self.title = title
        return self
    }

    func withCompleted(_ completed: Bool) -> ToDoItemBuilder {
        self.completed = completed
        return self
    }

    func build() -> ToDoItem {
        return ToDoItem(
            id: id,
            title: title,
            completed: completed
        )
    }
}
