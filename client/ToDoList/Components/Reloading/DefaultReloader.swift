// This protocol is created to duplicate the reloadData() method declaration on
//      UITableView and/or UICollectionView (and anything else that needs the
//      ability to be re-loaded).
//
// The conformance of UITableView to this protocol is managed in a separate file
//      under the UI because this requires importing UIKit - something that we
//      will try to limit to just those files under the UI folder.
protocol Reloadable {
    func reloadData()
}

// The Reloader is responsible for reloading a Reloadable object. This allows this
//      functionality to be easily testable so we can pass in any UITableView (or
//      UICollectionView, or any object that supports reloading) to confirm that
//      this functionality is executed.
protocol Reloader {
    func reload(reloadable: Reloadable)
}

struct DefaultReloader: Reloader {
    func reload(reloadable: Reloadable) {
        reloadable.reloadData()
    }
}
