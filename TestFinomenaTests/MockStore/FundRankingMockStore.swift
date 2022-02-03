//
//  FundRankingMockStore.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 2/2/2565 BE.
//

import Foundation

class FundRankingMockStore: FundRankingStoreProtocol {
  func getFundRanking(periodOption: PeriodOption, completion: @escaping (Result<FundRankingModel>) -> Void) {
    let fundRanking = FundRankingModel(data: [FundRankingModel.FundRankingData(mstarId: "F00000ZMXD",
                                                                               fundName: "PRINCIPAL VNEQ-A",
                                                                               navReturn: 74.80117,
                                                                               nav: 14.154,
                                                                               navDate: "2021-09-07T00:00:00.000Z",
                                                                               avgReturn: 63.633823),
                                              FundRankingModel.FundRankingData(mstarId: "F0000109C9",
                                                                               fundName: "PRINCIPAL VNEQ-I",
                                                                               navReturn: 74.79997,
                                                                               nav: 14.2656,
                                                                               navDate: "2021-09-07T00:00:00.000Z",
                                                                               avgReturn: 63.633823),
                                              FundRankingModel.FundRankingData(mstarId: "F00000HHFC",
                                                                               fundName: "KT-OIL",
                                                                               navReturn: 73.33466,
                                                                               nav: 3.4868,
                                                                               navDate: "2021-09-03T00:00:00.000Z",
                                                                               avgReturn: 65.394614)])
    completion(.success(result: fundRanking))
  }
}
