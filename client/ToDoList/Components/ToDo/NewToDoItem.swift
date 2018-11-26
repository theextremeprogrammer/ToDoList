struct NewToDoItem: Codable {
    let title: String
}

extension NewToDoItem: Equatable {
    static func ==(lhs: NewToDoItem, rhs: NewToDoItem) -> Bool {
        return lhs.title == rhs.title
    }
}
