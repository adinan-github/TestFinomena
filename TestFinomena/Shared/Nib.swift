//
//  Nib.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 2/2/2565 BE.
//

import Foundation
import UIKit

public protocol NibLoadableView: AnyObject {
  static var nibName: String { get }
}

public extension NibLoadableView where Self: UIView {
  static var nibName: String {
    return String(describing: self)
  }
}

public extension NibLoadableView {
  static private func bundle() -> Bundle {
    let bundle = Bundle(for: Self.self)
    return bundle
  }

  static fileprivate func nib() -> UINib {
    let nibName = Self.nibName
    let nib = UINib(nibName: nibName, bundle: bundle())
    return nib
  }

  static func loadNib() -> Self {
    let classes = nib().instantiate(withOwner: nil, options: nil)
    return classes.first as! Self
  }

  static func instanceFromNib() -> UIView {
    return nib().instantiate(withOwner: self, options: nil).first as! UIView
  }
}

extension UIView: NibLoadableView { }

// MARK: Cell Reuse for UITableView

// Apply this protocol to any UIView descendant
public protocol ReusableView: AnyObject {
  static var defaultReuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
  static var defaultReuseIdentifier: String {
    return String(describing: self)
  }
}

public extension UITableView {

  /// Register cell with automatically setting Identifier
  func register<T: UITableViewCell>(cellClass: T.Type)
    where T: ReusableView {
    register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
  }

  func register<T: UITableViewCell>(nibCellClass: T.Type)
    where T: ReusableView {
    register(T.nib(), forCellReuseIdentifier: T.defaultReuseIdentifier)
  }

  func register<T: UITableViewHeaderFooterView>(headerFooterClass: T.Type)
    where T: ReusableView {
      register(T.self, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
  }

  func register<T: UITableViewHeaderFooterView>(nibHeaderFooterClass: T.Type)
    where T: ReusableView {
    register(T.nib(), forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
  }

  /// Get cell with the default reuse identifier
  func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T
    where T: ReusableView {

    guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier,
                                         for: indexPath) as? T
      else {
      fatalError("Could not dequeue cell \(T.self) with identifier \(T.defaultReuseIdentifier)")
    }

    return cell
  }

  /// Get header/footer with the default reuse identifier
  func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T
    where T: ReusableView {

    guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier) as? T
      else {
        fatalError("Could not dequeue header/footer \(T.self) with identifier \(T.defaultReuseIdentifier)")
    }

    return cell
  }
}
