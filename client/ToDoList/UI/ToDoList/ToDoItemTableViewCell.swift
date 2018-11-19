import UIKit

class ToDoItemTableViewCell: UITableViewCell {
    func configure(toDoItem: ToDoItem) {
        textLabel?.text = toDoItem.title
    }
}
