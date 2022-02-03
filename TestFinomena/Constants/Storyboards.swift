// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen


import Foundation
import UIKit


internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
  }
}

internal struct SceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal struct InitialSceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal protocol SegueType: RawRepresentable { }

internal extension SegueType where RawValue == String {
  init?(_ segue: UIStoryboardSegue) {
    guard let identifier = segue.identifier else { return nil }
    self.init(rawValue: identifier)
  }
}

internal extension UIViewController {
  func perform<S: SegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
    let identifier = segue.rawValue
    performSegue(withIdentifier: identifier, sender: sender)
  }
}

internal enum StoryboardScene {
  internal enum FavouriteFund: StoryboardType {
    internal static let storyboardName = "FavouriteFund"

    internal static let initialScene = InitialSceneType<TestFinomena.FavouriteFundViewController>(storyboard: FavouriteFund.self)
  }
  internal enum FundRanking: StoryboardType {
    internal static let storyboardName = "FundRanking"

    internal static let initialScene = InitialSceneType<TestFinomena.FundRankingViewController>(storyboard: FundRanking.self)
  }
  internal enum LaunchScreen: StoryboardType {
    internal static let storyboardName = "LaunchScreen"

    internal static let initialScene = InitialSceneType<UIKit.UIViewController>(storyboard: LaunchScreen.self)
  }
  internal enum MainTabbar: StoryboardType {
    internal static let storyboardName = "MainTabbar"

    internal static let initialScene = InitialSceneType<TestFinomena.MainTabbarController>(storyboard: MainTabbar.self)
  }
  internal enum Setting: StoryboardType {
    internal static let storyboardName = "Setting"

    internal static let initialScene = InitialSceneType<TestFinomena.SettingViewController>(storyboard: Setting.self)
  }
}

internal enum StoryboardSegue {
}

private final class BundleToken {}
