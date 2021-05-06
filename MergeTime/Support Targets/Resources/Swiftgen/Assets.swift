// swiftlint:disable all

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// MARK: - Asset Catalogs

// extensions with convenience inits
fileprivate extension ColorAsset {
    convenience init(name: String) {
        self.init()
        self.name = name
        bundle = BundleToken.bundle
    }
}
fileprivate extension ImageAsset {
    convenience init(name: String) {
        self.init()
        self.name = name
        bundle = BundleToken.bundle
    }
}
extension Asset {
  public enum Assets {
    public enum TapBar {
      public static let account = ImageAsset(name: "TapBar/account")
      public static let road = ImageAsset(name: "TapBar/road")
      public static let storeroom = ImageAsset(name: "TapBar/storeroom")
    }
  }
  public enum Colors {
    public enum Background {
      public static let primary = ColorAsset(name: "Background/primary")
    }
    public enum Specific {
      public enum ItemContentViewBackground {
        public static let evenNumberCell = ColorAsset(name: "Specific/ItemContentViewBackground/evenNumberCell")
        public static let notEvenNumberCell = ColorAsset(name: "Specific/ItemContentViewBackground/notEvenNumberCell")
      }
      public static let itemContentViewBorder = ColorAsset(name: "Specific/itemContentViewBorder")
    }
    public enum Standard {
      public static let transparent = ColorAsset(name: "Standard/transparent")
      public static let white = ColorAsset(name: "Standard/white")
    }
    public enum Text {
      public static let primary = ColorAsset(name: "Text/primary")
    }
  }
}

private final class BundleToken {
  static let bundle = Bundle(for: BundleToken.self)
}
