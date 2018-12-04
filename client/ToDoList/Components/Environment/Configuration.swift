import Foundation

struct Configuration {
    static var environment: Environment {
        get {
            /*  In the Application's Info.plist a new key has been added called "Configuration".
             
                This key is set to a hard-coded value of "$(CONFIGURATION)" which is an Xcode
                build variable that will retrieve the name of the current build configuration
                that is set for the selected scheme.
             
                Standard build configurations for all Xcode projects include "Debug" and
                "Release". You can see all Configurations by accessing:
             
                Application -> Project -> <project name> -> Info tab -> Configurations
             
                The optional value is explicitly unwrapped as this should crash if this
                value cannot be found.
             */
            let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as! String
            
            /*  The string value of the configuration name is then passed as the raw value
                for the Environment enum which contains the definitions for all currently
                configured build configurations.

                The optional value is explicitly unwrapped as this should crash if this
                value cannot be found.
             */
            return Environment.init(rawValue: configuration)!
        }
    }
}
