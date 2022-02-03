//
//  AFRouterMethods.swift
//  Assignment2
//
//  Created by Adinan Yujaroen 
//  Copyright © 2563 name. All rights reserved.
//

import Foundation
import Alamofire

extension AFRouter {
  public var method: Alamofire.HTTPMethod {
    switch self {
    case .getFundRanking:
      return .get
    }
  }
}
