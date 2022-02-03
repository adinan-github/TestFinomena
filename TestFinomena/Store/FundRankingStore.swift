//
//  FundRankingStore.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 1/2/2565 BE.
//

import Foundation
import Alamofire

protocol FundRankingStoreProtocol {
  func getFundRanking(periodOption: PeriodOption, completion: @escaping(Result<FundRankingModel>) -> Void)
}

class FundRankingStore: FundRankingStoreProtocol {
  func getFundRanking(periodOption: PeriodOption, completion: @escaping(Result<FundRankingModel>) -> Void) {
    AF.request(AFRouter.getFundRanking(path: periodOption.rawValue)).responseJSON { response in
      switch response.result {
      case .success:
        do {
          let decoder = JSONDecoder()
          let result = try decoder.decode(FundRankingModel.self, from: response.data!)
          completion(.success(result: result))
        } catch let error {
          print(error)
          completion(.failure(error: .invalidJSON))
        }
      case .failure(let error):
        print(error)
        completion(.failure(error: .invalidData))
      }
    }
  }
}
