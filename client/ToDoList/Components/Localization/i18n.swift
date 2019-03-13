import Foundation

protocol LocalizedStringTemplate {
    var localized: String { get }
}

extension LocalizedStringTemplate {
    var localized: String {
        get {
            return NSLocalizedString(code(), comment: "")
        }
    }

    private var title: String {
        get {
            return String(describing: "\(type(of: self))")
        }
    }

    private func code() -> String {
        return "\(title)_\(self)".uppercased()
    }
}

struct i18n {
    enum AddToDoItem: LocalizedStringTemplate {
        case title
        case newToDoTitlePlaceholder
    }

    enum ToDoList: LocalizedStringTemplate {
        case title
    }
}
