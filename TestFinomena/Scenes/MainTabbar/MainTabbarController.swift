//
//  MainTabbarController.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 2/2/2565 BE.
//

import UIKit

class MainTabbarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpNotificationCenter()
    ServiceManager.shared().setLanguage()
  }
  
  private func setUpNotificationCenter() {
    NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange),
                                           name: Constants.NotificationNameLanguageChange, object: nil)
  }
  
  @objc func languageDidChange() {
    ServiceManager.shared().setLanguage()
    reloadAllTab()
  }
  
  /// Reload all tabs but the selected one
  func reloadAllTab() {
    for index in 0..<(unwrapped(viewControllers, with: [])).count {
      reloadStoryboard(inTab: index)
    }
  }

  // Reload given tab from its storyboard
  func reloadStoryboard(inTab tabIndex: Int) {
    guard let tab = viewControllers?[tabIndex], let newViewController = tab.storyboard?.instantiateInitialViewController() else {
      return
    }

    // Create new instance of the same Storyboard
    viewControllers?[tabIndex] = newViewController
  }
}
