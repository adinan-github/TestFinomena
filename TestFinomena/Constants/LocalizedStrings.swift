// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation


internal enum L10n {
  /// เปลี่ยนภาษาภายในแอพ
  internal static var changeLanguageTitle: String { return L10n.tr("Localizable", "change_language_title") }
  /// บันทึก
  internal static var favButtonTitleSave: String { return L10n.tr("Localizable", "fav_button_title_save") }
  /// ลบ
  internal static var favButtonTitleUnsave: String { return L10n.tr("Localizable", "fav_button_title_unsave") }
  /// กำไร 1 วัน
  internal static var optionReturnDay: String { return L10n.tr("Localizable", "option_return_day") }
  /// กำไร 1 เดือน
  internal static var optionReturnMonth: String { return L10n.tr("Localizable", "option_return_month") }
  /// กำไร 1 สัปดาห์
  internal static var optionReturnWeek: String { return L10n.tr("Localizable", "option_return_week") }
  /// กำไร 1 ปี
  internal static var optionReturnYear: String { return L10n.tr("Localizable", "option_return_year") }
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
