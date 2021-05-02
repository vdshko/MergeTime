// swiftlint:disable all

extension L10n {
  /// Account
  public static let tabBarAccount = L10n.tr("Localizable", "tabBar.account")
  /// Road
  public static let tabBarRoad = L10n.tr("Localizable", "tabBar.road")
  /// Storeroom
  public static let tabBarStoreroom = L10n.tr("Localizable", "tabBar.storeroom")
}

private extension L10n {
    static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {
  static let bundle = Bundle(for: BundleToken.self)
}
