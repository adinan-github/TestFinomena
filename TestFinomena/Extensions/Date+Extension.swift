//
//  Date+Extension.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 2/2/2565 BE.
//

import Foundation

extension Date {
  func getTimeStampFromDate() -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone.current
    formatter.dateFormat = "dd/MM/yyyy"
    return formatter.string(from: self)
  }
}
