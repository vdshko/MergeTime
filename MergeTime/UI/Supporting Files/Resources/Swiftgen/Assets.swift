// swiftlint:disable all

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases

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
  }
}

private final class BundleToken {
  static let bundle = Bundle(for: BundleToken.self)
}
