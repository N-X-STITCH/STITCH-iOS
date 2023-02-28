// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
import AppKit
#elseif os(iOS)
import UIKit
#elseif os(tvOS) || os(watchOS)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
extension UIColor {
    public static let background = ColorAsset(name: "Background").color
    public static let black = ColorAsset(name: "Black").color
    public static let error01 = ColorAsset(name: "Error01").color
    public static let error02 = ColorAsset(name: "Error02").color
    public static let gray01 = ColorAsset(name: "Gray-01").color
    public static let gray02 = ColorAsset(name: "Gray-02").color
    public static let gray04 = ColorAsset(name: "Gray-04").color
    public static let gray06 = ColorAsset(name: "Gray-06").color
    public static let gray07 = ColorAsset(name: "Gray-07").color
    public static let gray09 = ColorAsset(name: "Gray-09").color
    public static let gray10 = ColorAsset(name: "Gray-10").color
    public static let gray11 = ColorAsset(name: "Gray-11").color
    public static let gray12 = ColorAsset(name: "Gray-12").color
    public static let gray14 = ColorAsset(name: "Gray-14").color
    public static let onError = ColorAsset(name: "OnError").color
    public static let onSecondary = ColorAsset(name: "OnSecondary").color
    public static let secondary = ColorAsset(name: "Secondary").color
    public static let success = ColorAsset(name: "Success").color
    public static let surface = ColorAsset(name: "Surface").color
    public static let white = ColorAsset(name: "White").color
    public static let yellow0 = ColorAsset(name: "Yellow-0").color
    public static let yellow01 = ColorAsset(name: "Yellow-01").color
    public static let yellow02 = ColorAsset(name: "Yellow-02").color
    public static let yellow03 = ColorAsset(name: "Yellow-03").color
    public static let yellow04 = ColorAsset(name: "Yellow-04").color
    public static let yellow05_primary = ColorAsset(name: "Yellow-05").color
    public static let yellow06_pressed = ColorAsset(name: "Yellow-06").color
    public static let yellow07 = ColorAsset(name: "Yellow-07").color
    public static let yellow08 = ColorAsset(name: "Yellow-08").color
    public static let yellow09 = ColorAsset(name: "Yellow-09").color
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
    public fileprivate(set) var name: String
    
#if os(macOS)
    public typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
    public typealias Color = UIColor
#endif
    
    @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
    public private(set) lazy var color: Color = {
        guard let color = Color(asset: self) else {
            fatalError("Unable to load color asset named \(name).")
        }
        return color
    }()
    
#if os(iOS) || os(tvOS)
    @available(iOS 11.0, tvOS 11.0, *)
    public func color(compatibleWith traitCollection: UITraitCollection) -> Color {
        let bundle = BundleToken.bundle
        guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
            fatalError("Unable to load color asset named \(name).")
        }
        return color
    }
#endif
    
#if canImport(SwiftUI)
    @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
    public private(set) lazy var swiftUIColor: SwiftUI.Color = {
        SwiftUI.Color(asset: self)
    }()
#endif
    
    fileprivate init(name: String) {
        self.name = name
    }
}

public extension ColorAsset.Color {
    @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
    convenience init?(asset: ColorAsset) {
        let bundle = BundleToken.bundle
#if os(iOS) || os(tvOS)
        self.init(named: asset.name, in: bundle, compatibleWith: nil)
#elseif os(macOS)
        self.init(named: NSColor.Name(asset.name), bundle: bundle)
#elseif os(watchOS)
        self.init(named: asset.name)
#endif
    }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
    init(asset: ColorAsset) {
        let bundle = BundleToken.bundle
        self.init(asset.name, bundle: bundle)
    }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
#if SWIFT_PACKAGE
        return Bundle.module
#else
        return Bundle(for: BundleToken.self)
#endif
    }()
}
// swiftlint:enable convenience_type
