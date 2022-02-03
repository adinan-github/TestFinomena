//
//  FundViewCell.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 2/2/2565 BE.
//

import Foundation
import UIKit

protocol FundViewCellProtocol: AnyObject {
  func unFavCell(id: String)
}

struct FundViewModel: Codable {
  let fundName: String
  let nav: Float
  let navReturn: Float
  let navDate: String
  let avgReturn: Float
  var isFav: Bool
  let optionReturn: PeriodOption
  let mstarId: String
  
  init(fundName: String,
       nav: Float,
       navReturn: Float,
       navDate: String,
       avgReturn: Float,
       isFav: Bool,
       optionReturn: PeriodOption,
       mstarId: String) {
    self.fundName = fundName
    self.nav = nav
    self.navReturn = navReturn
    self.navDate = navDate
    self.avgReturn = avgReturn
    self.isFav = isFav
    self.optionReturn = optionReturn
    self.mstarId = mstarId
  }
}

class FundViewCell: UITableViewCell {
  @IBOutlet private weak var fundNameLabel: UILabel!
  @IBOutlet private weak var navLabel: UILabel!
  @IBOutlet private weak var navReturnLabel: UILabel!
  @IBOutlet private weak var navDateLabel: UILabel!
  @IBOutlet private weak var favButton: UIButton!
  @IBOutlet private weak var optionReturnLabel: UILabel!
  @IBOutlet private weak var optionReturnView: UIView!
  
  var isFav: Bool = false
  var viewModel: FundViewModel?
  var delegate: FundViewCellProtocol?
  
  static let identifier = "FundViewCell"
  
  func updateUI(viewModel: FundViewModel) {
    self.viewModel = viewModel
    fundNameLabel.text = viewModel.fundName
    navLabel.text = "NAV: \(viewModel.nav)"
    navReturnLabel.text = "\(viewModel.navReturn.toStringTwoDigit())%"
    navDateLabel.text = "\(L10n.updateNavDateTitle) \(viewModel.navDate)"
    setOptionReturn(option: viewModel.optionReturn)
    setFavButton(isFav: viewModel.isFav)
  }
  
  func setHideOptionReturnView(isFromFav: Bool) {
    if isFromFav {
      optionReturnView.isHidden = false
    } else {
      optionReturnView.isHidden = true
    }
  }
  
  @IBAction private func favButtonTaped() {
    setFavButton(isFav: !isFav)
    saveFavFund(isFav: self.isFav)
  }
  
  private func setFavButton(isFav: Bool) {
    self.isFav = isFav
    if isFav {
      favButton.setTitle(L10n.favButtonTitleUnsave, for: .normal)
      favButton.backgroundColor = UIColor.orange
    } else {
      favButton.setTitle(L10n.favButtonTitleSave, for: .normal)
      favButton.backgroundColor = UIColor.systemYellow
    }
  }
  
  private func setOptionReturn(option: PeriodOption) {
    switch option {
    case .day:
      optionReturnLabel.text = OptionReturn.day.rawValue
    case .week:
      optionReturnLabel.text = OptionReturn.week.rawValue
    case .month:
      optionReturnLabel.text = OptionReturn.month.rawValue
    case .year:
      optionReturnLabel.text = OptionReturn.year.rawValue
    }
  }
  
  private func saveFavFund(isFav: Bool) {
    let favList = ServiceManager.shared().getFavListFromDatabase()
    viewModel?.isFav = isFav
    guard let viewModel = self.viewModel else {
      return
    }
    
    if favList.contains(where: { $0.mstarId == viewModel.mstarId}) {
      ServiceManager.shared().removeFavDataInFavListFromUserDefault(mstarId: viewModel.mstarId)
      delegate?.unFavCell(id: viewModel.mstarId)
    } else {
      ServiceManager.shared().setFavFundToDatabase(favFund: viewModel)
      ServiceManager.shared().events(screenName: "FundRanking", action: "Save_Fund", item: viewModel.fundName)
    }
  }
}
