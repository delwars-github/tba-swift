import Foundation
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ColorResource {

}

// MARK: - Image Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ImageResource {

    /// The "app-icon" asset catalog image resource.
    static let appIcon = DeveloperToolsSupport.ImageResource(name: "app-icon", bundle: resourceBundle)

    /// The "arrow-ul-icon" asset catalog image resource.
    static let arrowUlIcon = DeveloperToolsSupport.ImageResource(name: "arrow-ul-icon", bundle: resourceBundle)

    /// The "calendar-love-icon" asset catalog image resource.
    static let calendarLoveIcon = DeveloperToolsSupport.ImageResource(name: "calendar-love-icon", bundle: resourceBundle)

    /// The "creative-icon" asset catalog image resource.
    static let creativeIcon = DeveloperToolsSupport.ImageResource(name: "creative-icon", bundle: resourceBundle)

    /// The "dollar-icon" asset catalog image resource.
    static let dollarIcon = DeveloperToolsSupport.ImageResource(name: "dollar-icon", bundle: resourceBundle)

    /// The "earn-icon" asset catalog image resource.
    static let earnIcon = DeveloperToolsSupport.ImageResource(name: "earn-icon", bundle: resourceBundle)

    /// The "event-active-icon" asset catalog image resource.
    static let eventActiveIcon = DeveloperToolsSupport.ImageResource(name: "event-active-icon", bundle: resourceBundle)

    /// The "event-icon" asset catalog image resource.
    static let eventIcon = DeveloperToolsSupport.ImageResource(name: "event-icon", bundle: resourceBundle)

    /// The "filter-icon" asset catalog image resource.
    static let filterIcon = DeveloperToolsSupport.ImageResource(name: "filter-icon", bundle: resourceBundle)

    /// The "home-1" asset catalog image resource.
    static let home1 = DeveloperToolsSupport.ImageResource(name: "home-1", bundle: resourceBundle)

    /// The "home-2" asset catalog image resource.
    static let home2 = DeveloperToolsSupport.ImageResource(name: "home-2", bundle: resourceBundle)

    /// The "home-3" asset catalog image resource.
    static let home3 = DeveloperToolsSupport.ImageResource(name: "home-3", bundle: resourceBundle)

    /// The "home-active-icon" asset catalog image resource.
    static let homeActiveIcon = DeveloperToolsSupport.ImageResource(name: "home-active-icon", bundle: resourceBundle)

    /// The "home-bg" asset catalog image resource.
    static let homeBg = DeveloperToolsSupport.ImageResource(name: "home-bg", bundle: resourceBundle)

    /// The "home-icon" asset catalog image resource.
    static let homeIcon = DeveloperToolsSupport.ImageResource(name: "home-icon", bundle: resourceBundle)

    /// The "home-top" asset catalog image resource.
    static let homeTop = DeveloperToolsSupport.ImageResource(name: "home-top", bundle: resourceBundle)

    /// The "j1" asset catalog image resource.
    static let j1 = DeveloperToolsSupport.ImageResource(name: "j1", bundle: resourceBundle)

    /// The "j2" asset catalog image resource.
    static let j2 = DeveloperToolsSupport.ImageResource(name: "j2", bundle: resourceBundle)

    /// The "j3" asset catalog image resource.
    static let j3 = DeveloperToolsSupport.ImageResource(name: "j3", bundle: resourceBundle)

    /// The "j4" asset catalog image resource.
    static let j4 = DeveloperToolsSupport.ImageResource(name: "j4", bundle: resourceBundle)

    /// The "j5" asset catalog image resource.
    static let j5 = DeveloperToolsSupport.ImageResource(name: "j5", bundle: resourceBundle)

    /// The "j6" asset catalog image resource.
    static let j6 = DeveloperToolsSupport.ImageResource(name: "j6", bundle: resourceBundle)

    /// The "main-logo" asset catalog image resource.
    static let mainLogo = DeveloperToolsSupport.ImageResource(name: "main-logo", bundle: resourceBundle)

    /// The "notification-icon" asset catalog image resource.
    static let notificationIcon = DeveloperToolsSupport.ImageResource(name: "notification-icon", bundle: resourceBundle)

    /// The "pro-check-icon" asset catalog image resource.
    static let proCheckIcon = DeveloperToolsSupport.ImageResource(name: "pro-check-icon", bundle: resourceBundle)

    /// The "profile-pic" asset catalog image resource.
    static let profilePic = DeveloperToolsSupport.ImageResource(name: "profile-pic", bundle: resourceBundle)

    /// The "soul-icon" asset catalog image resource.
    static let soulIcon = DeveloperToolsSupport.ImageResource(name: "soul-icon", bundle: resourceBundle)

    /// The "user-active-icon" asset catalog image resource.
    static let userActiveIcon = DeveloperToolsSupport.ImageResource(name: "user-active-icon", bundle: resourceBundle)

    /// The "user-icon" asset catalog image resource.
    static let userIcon = DeveloperToolsSupport.ImageResource(name: "user-icon", bundle: resourceBundle)

}

