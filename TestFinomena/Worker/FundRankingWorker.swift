//
//  FundRankingWorker.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 1/2/2565 BE.
//

import Foundation

class FundRankingWorker {
  
  var store: FundRankingStoreProtocol
  
  init(store: FundRankingStoreProtocol) {
    self.store = store
  }
  
  func getFundRankingD(periodOption: PeriodOption, completion: @escaping(Result<FundRankingModel>) -> Void) {
    store.getFundRanking(periodOption: periodOption, completion: completion)
  }
}
