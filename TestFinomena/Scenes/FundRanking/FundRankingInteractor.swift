//
//  FundRankingInteractor.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 2/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FundRankingInteractorInterface {
  func getFundRankingList(request: FundRanking.GetFundRankingList.Request)
}

class FundRankingInteractor: FundRankingInteractorInterface {
  var presenter: FundRankingPresenterInterface!
  var worker: FundRankingWorker!

  // MARK: - Business logic
  func getFundRankingList(request: FundRanking.GetFundRankingList.Request) {
    worker.getFundRankingD(periodOption: request.periodOption) { [weak self] result in
      var response: FundRanking.GetFundRankingList.Response
      switch result {
      case .success(let data):
        let fundData = FundRanking.GetFundRankingList.Response.FundRankingData(periodOption: request.periodOption,
                                                                               fundList: data.data)
        response = FundRanking.GetFundRankingList.Response(result: .success(result: fundData))
      case .failure(let error):
        response = FundRanking.GetFundRankingList.Response(result: .failure(error: error))
      }
      self?.presenter.presentFundRanking(response: response)
    }
  }
}
