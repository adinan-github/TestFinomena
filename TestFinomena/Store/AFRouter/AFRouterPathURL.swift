//
//  AFRouterPathURL.swift
//  Assignment2
//
//  Created by Adinan Yujaroen 
//  Copyright © 2563 name. All rights reserved.
//

import Foundation
import UIKit

extension AFRouter {
  public var path: String {
    switch self {
    case .getFundRanking(let path):
      return path
    }
  }
}
