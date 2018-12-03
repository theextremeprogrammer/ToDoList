import Foundation

struct Configuration {
    static var environment: Environment {
        get {
            if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String,
                let environment = Environment.init(rawValue: configuration) {
                return environment
            }
            
            return Environment.Debug
        }
    }
}
