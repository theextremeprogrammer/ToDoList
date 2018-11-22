struct NewToDo {
    let title: String
}

extension NewToDo: Equatable {}

func ==(lhs: NewToDo, rhs: NewToDo) -> Bool {
    return lhs.title == rhs.title
}
