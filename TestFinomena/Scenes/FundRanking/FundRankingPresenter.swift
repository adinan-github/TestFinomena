//
//  FundRankingPresenter.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 2/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FundRankingPresenterInterface {
  func presentFundRanking(response: FundRanking.GetFundRankingList.Response)
}

class FundRankingPresenter: FundRankingPresenterInterface {
  weak var viewController: FundRankingViewControllerInterface!

  // MARK: - Presentation logic
  func presentFundRanking(response: FundRanking.GetFundRankingList.Response) {
    var viewModel: FundRanking.GetFundRankingList.ViewModel
    switch response.result {
    case .success(let data):
      viewModel = FundRanking.GetFundRankingList.ViewModel(content: .success(result: handleFundListData(fundData: data)))
    case .failure(let error):
      viewModel = FundRanking.GetFundRankingList.ViewModel(content: .failure(error: error))
    }
    viewController.displayFundRanking(viewModel: viewModel)
  }
  
  // Private function
  private func handleFundListData(fundData: FundRanking.GetFundRankingList.Response.FundRankingData) -> [FundViewModel] {
    let fundViewModels = fundData.fundList.map { data -> FundViewModel in
      let fundViewModel = FundViewModel(fundName: data.fundName,
                                        nav: data.nav,
                                        navReturn: data.navReturn,
                                        navDate: unwrapped(data.navDate.getDateFromTimeStamp()?.getTimeStampFromDate(), with: ""),
                                        avgReturn: data.avgReturn,
                                        isFav: checkFavStatus(fundData: data),
                                        optionReturn: fundData.periodOption,
                                        mstarId: data.mstarId)
      return fundViewModel
    }
    return fundViewModels
  }
  
  private func checkFavStatus(fundData: FundRankingModel.FundRankingData) -> Bool {
    let favList = ServiceManager.shared().getFavListFromDatabase()
    if favList.contains(where: { $0.mstarId == fundData.mstarId }) {
      return true
    }
    return false
  }
}
