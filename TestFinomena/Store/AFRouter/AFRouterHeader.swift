//
//  AFRouterHeader.swift
//  Assignment2
//
//  Created by Adinan Yujaroen 
//  Copyright © 2563 name. All rights reserved.
//

import Foundation

extension AFRouter {
  public var headers: [String: String]? {
    switch self {
    default:
      return nil
    }
  }
  
  public func setHttpHeaders(_ mutableURLRequest: inout URLRequest, headers: [String: String]?) {
    addDefaultHttpHeader(&mutableURLRequest)
    if let headers = headers {
      for each in headers.keys {
        mutableURLRequest.setValue(headers[each], forHTTPHeaderField: each)
      }
    }
  }
  
  private func addDefaultHttpHeader(_ mutableURLRequest: inout URLRequest) {
    mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
  }
}
