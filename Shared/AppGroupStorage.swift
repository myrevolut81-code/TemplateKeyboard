import Foundation

enum AppGroup {
    static let identifier = "group.templatekeyboard.shared"
    static let categoriesKey = "categories"

    static var defaults: UserDefaults {
        UserDefaults(suiteName: identifier) ?? .standard
    }
}
