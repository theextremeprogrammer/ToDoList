struct NewToDoItem: Codable {
    let title: String
}

extension NewToDoItem: Equatable {
    static func ==(lhs: NewToDoItem, rhs: NewToDoItem) -> Bool {
        return lhs.title == rhs.title
    }
}

final class NewToDoItemBuilder {
    private var title: String = ""

    func withTitle(_ title: String) -> NewToDoItemBuilder {
        self.title = title
        return self
    }

    func build() -> NewToDoItem {
        return NewToDoItem(
            title: title
        )
    }
}
