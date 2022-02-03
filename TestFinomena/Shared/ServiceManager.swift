//
//  ServiceManager.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 1/2/2565 BE.
//

import Foundation
import MaterialComponents.MaterialActivityIndicator
import Firebase

class ServiceManager {
  private static var sharedServiceManager: ServiceManager = {
    let serviceManager = ServiceManager()
    return serviceManager
  }()
  
  private init() {
  }
  
  class func shared() -> ServiceManager {
    return sharedServiceManager
  }
  
  private var vSpinner: UIView?
  
  func showLoader(view: UIView) {
    let spinnerView = UIView.init(frame: view.bounds)
    spinnerView.backgroundColor = UIColor.clear
    
    let loadingView: UIView = UIView()
    loadingView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
    loadingView.center = spinnerView.center
    loadingView.backgroundColor = UIColor.clear
    
    let activityIndicator = MDCActivityIndicator(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
    activityIndicator.radius = 23.0
    activityIndicator.strokeWidth = 3
    
    loadingView.addSubview(activityIndicator)
    
    DispatchQueue.main.async {
      spinnerView.addSubview(loadingView)
      activityIndicator.startAnimating()
      //      let topView = UIApplication.shared.windows.first?.rootViewController
      //      topView?.view.addSubview(spinnerView)
      view.addSubview(spinnerView)
    }
    
    vSpinner = spinnerView
  }
  
  func stopLoader() {
    DispatchQueue.main.async {
      self.vSpinner?.removeFromSuperview()
      self.vSpinner = nil
    }
  }
  
  func setLanguage() {
    let language = getLanguageFromDatabase()
    
    var selectedLanguage = language
    if language.count == 0 {
      selectedLanguage = "en"
    }
    UserDefaults.standard.set([selectedLanguage], forKey: "AppleLanguages")
    UserDefaults.standard.synchronize()
    
    // Update the language by swaping bundle
    Bundle.setLanguage(selectedLanguage)
  }
  
  func events(screenName: String, action: String, item: String) {
    Analytics.logEvent("\(screenName)", parameters: ["Action": action as NSObject,
                                                     "Fund": item as NSObject])
  }
  
  func setFavFundToDatabase(favFund: FundViewModel) {
    var favList = getFavListFromDatabase()
    favList.append(favFund)
    let encoder = JSONEncoder()
    if let favFundListLog = try? encoder.encode(favList) {
      UserDefaults.standard.set(favFundListLog, forKey: "Fav_List")
    }
  }
  
  func getFavListFromDatabase() -> [FundViewModel] {
    if let data = UserDefaults.standard.object(forKey: "Fav_List") as? Data {
      let decoder = JSONDecoder()
      if let favList = try? decoder.decode([FundViewModel].self, from: data) {
        return favList
      }
    }
    return []
  }
  
  func removeFavListFromDatabase() {
    UserDefaults.standard.removeObject(forKey: "Fav_List")
  }
  
  func removeFavDataInFavListFromUserDefault(mstarId: String) {
    var favList = getFavListFromDatabase()
    
    favList.removeAll(where: { $0.mstarId == mstarId })
    
    let encoder = JSONEncoder()
    if let favFundListLog = try? encoder.encode(favList) {
      UserDefaults.standard.set(favFundListLog, forKey: "Fav_List")
    }
  }
  
  func setLanguageToDatabase(language: String) {
    UserDefaults.standard.set(language, forKey: "Language")
  }
  
  func getLanguageFromDatabase() -> String {
    return unwrapped(UserDefaults.standard.string(forKey: "Language"), with: "en")
  }
}
