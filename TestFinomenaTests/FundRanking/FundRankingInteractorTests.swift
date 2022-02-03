//
//  FundRankingInteractorTests.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 3/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import TestFinomena
import XCTest

class FundRankingInteractorTests: XCTestCase {

  // MARK: - Subject under test

  var interactor: FundRankingInteractor!
  var worker: FundRankingWorkerSpy!
  var presenterSpy: FundRankingPresenterSpy!

  class FundRankingPresenterSpy: FundRankingPresenterInterface {
    var presentFundRankingCalled: Bool = false
    var presentFundRankingResponse: FundRanking.GetFundRankingList.Response!
    
    func presentFundRanking(response: FundRanking.GetFundRankingList.Response) {
      presentFundRankingCalled = true
      presentFundRankingResponse = response
    }
  }
  
  class FundRankingWorkerSpy: FundRankingWorker {
    var forceFailure: Bool = false
    
    override func getFundRankingD(periodOption: PeriodOption, completion: @escaping (Result<FundRankingModel>) -> Void) {
      if forceFailure {
        completion(.failure(error: .invalidData))
      } else {
        super.getFundRankingD(periodOption: periodOption, completion: completion)
      }
    }
  }
  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupFundRankingInteractor()
  }

  // MARK: - Test setup

  func setupFundRankingInteractor() {
    interactor = FundRankingInteractor()
    
    worker = FundRankingWorkerSpy(store: FundRankingMockStore())
    interactor.worker = worker
    
    presenterSpy = FundRankingPresenterSpy()
    interactor.presenter = presenterSpy
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testGetFundRankingListCaseSuccess() {
    // Given
    let request = FundRanking.GetFundRankingList.Request(periodOption: .year)
    
    // When
    interactor.getFundRankingList(request: request)
    
    // Then
    XCTAssertTrue(presenterSpy.presentFundRankingCalled, "getFundRankingList() should ask to presentFundRanking()")
    
    switch presenterSpy.presentFundRankingResponse.result {
    case .success(let result):
      XCTAssertEqual(result.periodOption, .year)
      XCTAssertEqual(result.fundList.count, 3)
      XCTAssertEqual(result.fundList.first?.fundName, "PRINCIPAL VNEQ-A")
      XCTAssertEqual(result.fundList.first?.mstarId, "F00000ZMXD")
      XCTAssertEqual(result.fundList.first?.navReturn, 74.80117)
      XCTAssertEqual(result.fundList.first?.nav, 14.154)
      XCTAssertEqual(result.fundList.first?.navDate, "2021-09-07T00:00:00.000Z")
      XCTAssertEqual(result.fundList.first?.avgReturn, 63.633823)
    case .failure(let error):
      XCTFail("This case should be success")
    }
  }
  
  func testGetFundRankingListCaseFailure() {
    // Given
    let request = FundRanking.GetFundRankingList.Request(periodOption: .year)
    worker.forceFailure = true
    
    // When
    interactor.getFundRankingList(request: request)
    
    // Then
    XCTAssertTrue(presenterSpy.presentFundRankingCalled, "getFundRankingList() should ask to presentFundRanking()")
    switch presenterSpy.presentFundRankingResponse.result {
    case .success:
      XCTFail("This case should be failure")
    case .failure(let error):
      XCTAssertEqual(error, APIError.invalidData)
    }
  }
}
