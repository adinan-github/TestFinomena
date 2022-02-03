//
//  Error.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 2/2/2565 BE.
//

import Foundation

public enum APIError: Error {
  case invalidJSON
  case invalidData
}

public enum Result<T> {
  case success(result: T)
  case failure(error: APIError)
}

public enum Content<T> {
  case success(result: T)
  case failure(error: Error)
}
