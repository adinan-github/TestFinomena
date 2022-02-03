//
//  AFRouterProtocol.swift
//  Assignment2
//
//  Created by Adinan Yujaroen
//  Copyright © 2563 name. All rights reserved.
//

import Foundation
import Alamofire

public protocol AFRouterProtocol: URLRequestConvertible {
  var baseURLString: String { get }
  var path: String { get }
  var method: Alamofire.HTTPMethod { get }
  var headers: [String: String]? { get }
  var parameters: [String: Any]? { get }
  var rawBody: NSData { get }
}
