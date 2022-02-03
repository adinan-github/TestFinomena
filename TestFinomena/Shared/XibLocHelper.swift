//
//  XibLocHelper.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 1/2/2565 BE.
//

import Foundation
import UIKit

protocol Localizable {
  var localized: String { get }
}
extension String: Localizable {
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}

protocol XIBLocalizable {
  var xibLocKey: String? { get set }
}

extension UILabel: XIBLocalizable {
  @IBInspectable var xibLocKey: String? {
    get { return nil }
    set(key) {
      guard let key = key else { return }
      text = key.localized
    }
  }
}

extension UIButton: XIBLocalizable {
  @IBInspectable var xibLocKey: String? {
    get { return nil }
    set(key) {
      guard let key = key else { return }
      setTitle(key.localized, for: .normal)
    }
  }
}

extension UITextField: XIBLocalizable {
  @IBInspectable var xibLocKey: String? {
    get { return nil }
    set(key) {
      guard let key = key else { return }
      if key.contains("placeholder") {
        placeholder = key.localized
      } else {
        text = key.localized
      }
    }
  }
}

extension UITextView: XIBLocalizable {
  @IBInspectable var xibLocKey: String? {
    get { return nil }
    set(key) {
      guard let key = key else { return }
      text = key.localized
    }
  }
}

extension UINavigationItem: XIBLocalizable {
  @IBInspectable var xibLocKey: String? {
    get { return nil }
    set(key) {
      guard let key = key else { return }
      title = key.localized
    }
  }
}

extension UIBarButtonItem: XIBLocalizable {
  @IBInspectable var xibLocKey: String? {
    get { return nil }
    set(key) {
      guard let key = key else { return }
      title = key.localized
    }
  }
}

extension UIViewController: XIBLocalizable {
  @IBInspectable var xibLocKey: String? {
    get { return nil }
    set(key) {
      guard let key = key else { return }
      title = key.localized
    }
  }
}
