struct NewToDoItem: Codable {
    let title: String
}

extension NewToDoItem: Equatable {}

func ==(lhs: NewToDoItem, rhs: NewToDoItem) -> Bool {
    return lhs.title == rhs.title
}
