enum Environment: String {
    /*  The following valid values for this enum map directly to the build configuration
        names as defined for this project in Xcode under:
     
        Application -> Project -> <project name> -> Info tab -> Configurations
     */
    case Debug
    case Staging
    case Release

    /*  Any values which need to be configured differently per environment can then
        be organized here.
     */
    var baseURL: String {
        switch self {
        case .Debug: return "http://localhost:8080"
        case .Staging: return "https://todolistserver.cfapps.io"
        case .Release: return ""
        }
    }
}
