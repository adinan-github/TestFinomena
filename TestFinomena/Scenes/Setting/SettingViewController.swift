//
//  SettingViewController.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 3/2/2565 BE.
//

import UIKit

class SettingViewController: UIViewController {
  @IBOutlet private weak var segmentControl: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setSegment()
  }
  
  private func setSegment() {
    if ServiceManager.shared().getLanguageFromDatabase() == "th" {
      segmentControl.selectedSegmentIndex = 0
    } else {
      segmentControl.selectedSegmentIndex = 1
    }
  }
  
  @IBAction func languageChanged(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0:
      ServiceManager.shared().setLanguageToDatabase(language: "th")
    case 1:
      ServiceManager.shared().setLanguageToDatabase(language: "en")
    default:
      print("default")
    }
    NotificationCenter.default.post(name: Constants.NotificationNameLanguageChange, object: nil)
  }
}
