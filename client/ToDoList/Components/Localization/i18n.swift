import Foundation

// Each localized string has a key and a value defined for it. The key is used in
//      the Localizable.strings file and the value is what is retrieved from that
//      file if it is configured properly.
protocol LocalizedStringCategory {
    var localizedStringKey: String { get }
    var value: String { get }
}

// This protocol extension automatically generates a key for each enum that
//      implements this protocol. It also converts the key to its localized value
//      for use within the app.
extension LocalizedStringCategory {
    var localizedStringKey: String {
        get {
            let categoryValue = "\(self)"
            let localizedStringCode = categoryName + "_" + categoryValue

            return localizedStringCode.uppercased()
        }
    }

    var value: String {
        get {
            return NSLocalizedString(localizedStringKey, comment: "")
        }
    }

    private var categoryName: String {
        get {
            return String(describing: "\(type(of: self))")
        }
    }
}

// i18n is a discoverable struct composed of "Categories" which can easily map to
//      screens or functionality within the app. A "LocalizedStringCategory" will
//      automatically build the localized string key reducing the risk of making
//      a mistake trying to type to proper key. This also gives convenient type-
//      ahead and organization to all of the strings that need to be localized.
//
// Simply add a new enum inside the i18n struct for each screen or groupinng of
//      functionality inn your app and then inside each enum add a case for each
//      string that is needed.
struct i18n {
    enum AddToDoItem: LocalizedStringCategory {
        case title
        case newToDoTitlePlaceholder
    }

    enum ToDoList: LocalizedStringCategory {
        case title
    }
}
