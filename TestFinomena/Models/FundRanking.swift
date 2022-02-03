//
//  FundRanking.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 2/2/2565 BE.
//

import Foundation

struct FundRankingModel: Codable {
  let data: [FundRankingData]
  
  struct FundRankingData: Codable {
    let mstarId: String
    let fundName: String
    let navReturn: Float
    let nav: Float
    let navDate: String
    let avgReturn: Float
    
    init(mstarId: String, fundName: String, navReturn: Float, nav: Float, navDate: String, avgReturn: Float) {
      self.mstarId = mstarId
      self.fundName = fundName
      self.navReturn = navReturn
      self.nav = nav
      self.navDate = navDate
      self.avgReturn = avgReturn
    }
    
    enum CodingKeys: String, CodingKey {
      case mstarId = "mstar_id"
      case fundName = "thailand_fund_code"
      case navReturn = "nav_return"
      case nav
      case navDate = "nav_date"
      case avgReturn = "avg_return"
    }
  }
}

enum PeriodOption: String, Codable {
  case day = "/fund-ranking-1D.json"
  case week = "/fund-ranking-1W.json"
  case month = "/fund-ranking-1M.json"
  case year = "/fund-ranking-1Y.json"
}
