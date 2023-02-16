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
public extension UIColor {
    static let black = ColorAsset(name: "Black")
    static let blue01 = ColorAsset(name: "Blue-01")
    static let blue02 = ColorAsset(name: "Blue-02")
    static let blue03 = ColorAsset(name: "Blue-03")
    static let blue04 = ColorAsset(name: "Blue-04")
    static let blue05 = ColorAsset(name: "Blue-05")
    static let blue06 = ColorAsset(name: "Blue-06")
    static let blue07 = ColorAsset(name: "Blue-07")
    static let blue08 = ColorAsset(name: "Blue-08")
    static let blue09 = ColorAsset(name: "Blue-09")
    static let blue10 = ColorAsset(name: "Blue-10")
    static let error = ColorAsset(name: "Error")
    static let errorPressed = ColorAsset(name: "ErrorPressed")
    static let gray01 = ColorAsset(name: "Gray-01")
    static let gray02 = ColorAsset(name: "Gray-02")
    static let gray03 = ColorAsset(name: "Gray-03")
    static let gray04 = ColorAsset(name: "Gray-04")
    static let gray05 = ColorAsset(name: "Gray-05")
    static let gray06 = ColorAsset(name: "Gray-06")
    static let gray07 = ColorAsset(name: "Gray-07")
    static let gray08 = ColorAsset(name: "Gray-08")
    static let gray09 = ColorAsset(name: "Gray-09")
    static let gray10 = ColorAsset(name: "Gray-10")
    static let gray11 = ColorAsset(name: "Gray-11")
    static let gray12 = ColorAsset(name: "Gray-12")
    static let gray13 = ColorAsset(name: "Gray-13")
    static let gray14 = ColorAsset(name: "Gray-14")
    static let gray15 = ColorAsset(name: "Gray-15")
    static let onSecondary = ColorAsset(name: "OnSecondary")
    static let red01 = ColorAsset(name: "Red-01")
    static let red02 = ColorAsset(name: "Red-02")
    static let red03 = ColorAsset(name: "Red-03")
    static let red04 = ColorAsset(name: "Red-04")
    static let red05 = ColorAsset(name: "Red-05")
    static let red06 = ColorAsset(name: "Red-06")
    static let red07 = ColorAsset(name: "Red-07")
    static let red08 = ColorAsset(name: "Red-08")
    static let red09 = ColorAsset(name: "Red-09")
    static let secondary = ColorAsset(name: "Secondary")
    static let success = ColorAsset(name: "Success")
    static let white = ColorAsset(name: "White")
    static let yellow01 = ColorAsset(name: "Yellow-01")
    static let yellow02 = ColorAsset(name: "Yellow-02")
    static let yellow03 = ColorAsset(name: "Yellow-03")
    static let yellow04 = ColorAsset(name: "Yellow-04")
    static let yellow05 = ColorAsset(name: "Yellow-05")
    static let yellow06 = ColorAsset(name: "Yellow-06")
    static let yellow07 = ColorAsset(name: "Yellow-07")
    static let yellow08 = ColorAsset(name: "Yellow-08")
    static let yellow09 = ColorAsset(name: "Yellow-09")
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
