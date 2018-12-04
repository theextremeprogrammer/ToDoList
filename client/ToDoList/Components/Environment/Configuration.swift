import Foundation

struct Configuration {
    static var environment: Environment {
        get {
            let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as! String
            return Environment.init(rawValue: configuration)!
        }
    }
}
