//
//  FundRankingModels.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 2/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct FundRanking {
  
  struct GetFundRankingList {
    
    struct Request {
      let periodOption: PeriodOption
    }
    
    struct Response {
      struct FundRankingData {
        let periodOption: PeriodOption
        let fundList: [FundRankingModel.FundRankingData]
      }
      
      let result: Result<FundRankingData>
    }
    
    struct ViewModel {
      let content: Content<[FundViewModel]>
    }
  }
}
