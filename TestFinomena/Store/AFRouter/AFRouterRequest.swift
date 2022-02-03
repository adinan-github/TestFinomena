//
//  AFRouterRequest.swift
//  Assignment2
//
//  Created by Adinan Yujaroen 
//  Copyright © 2563 name. All rights reserved.
//

import Foundation
import Alamofire

extension AFRouter {
  public var rawBody: NSData {
    switch self {
    default:
      return NSData()
    }
  }
}

extension AFRouter {
  public func asURLRequest() throws -> URLRequest {
    let url = URL(string: baseURLString + path)!
    var mutableURLRequest = URLRequest(url: url)
    mutableURLRequest.httpMethod = method.rawValue
    mutableURLRequest.httpBody = nil
    setHttpHeaders(&mutableURLRequest, headers: headers)
    
    return try Alamofire.JSONEncoding.default.encode(mutableURLRequest, with: parameters)
  }
}
