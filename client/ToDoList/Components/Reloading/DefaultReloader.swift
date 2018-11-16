protocol Reloadable {
    func reloadData()
}

protocol Reloader {
    func reload(reloadable: Reloadable)
}

