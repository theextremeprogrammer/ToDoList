import UIKit

final class ToDoListViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = UIColor.orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
