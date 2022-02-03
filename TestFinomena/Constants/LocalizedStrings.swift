// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation


internal enum L10n {
  /// เปลี่ยนภาษาภายในแอพ
  internal static var changeLanguageTitle: String { return L10n.tr("Localizable", "change_language_title") }
  /// บันทึก
  internal static var favButtonTitleSave: String { return L10n.tr("Localizable", "fav_button_title_save") }
  /// ลบ
  internal static var favButtonTitleUnsave: String { return L10n.tr("Localizable", "fav_button_title_unsave") }
  /// ข้อมูลอัพเดตเมื่อ:
  internal static var updateNavDateTitle: String { return L10n.tr("Localizable", "update_nav_date_title") }
}

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    #if os(iOS)
    let bundle = Bundle.main
    #elseif os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    #endif
    let format = NSLocalizedString(key, tableName: table, bundle: bundle, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
