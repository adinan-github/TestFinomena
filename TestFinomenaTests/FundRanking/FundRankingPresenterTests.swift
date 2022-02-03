//
//  FundRankingPresenterTests.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 3/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import TestFinomena
import XCTest

class FundRankingPresenterTests: XCTestCase {

  // MARK: - Subject under test

  var presenter: FundRankingPresenter!
  var viewcontrollerSpy: FundRankingViewControllerSpy!
  
  class FundRankingViewControllerSpy: FundRankingViewControllerInterface {
    var displayFundRankingCalled: Bool = false
    var displayFundRankingViewModel: FundRanking.GetFundRankingList.ViewModel!
    
    func displayFundRanking(viewModel: FundRanking.GetFundRankingList.ViewModel) {
      displayFundRankingCalled = true
      displayFundRankingViewModel = viewModel
    }
  }

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupFundRankingPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupFundRankingPresenter() {
    presenter = FundRankingPresenter()
    
    viewcontrollerSpy = FundRankingViewControllerSpy()
    presenter.viewController = viewcontrollerSpy
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testPresentFundRankingCaseSuccess() {
    // Given
    let fundList = [FundRankingModel.FundRankingData(mstarId: "F00000ZMXD",
                                                     fundName: "PRINCIPAL VNEQ-A",
                                                     navReturn: 74.80117,
                                                     nav: 14.154,
                                                     navDate: "2021-09-07T00:00:00.000Z",
                                                     avgReturn: 63.633823),
                    FundRankingModel.FundRankingData(mstarId: "F0000109C9",
                                                     fundName: "PRINCIPAL VNEQ-I",
                                                     navReturn: 74.79997,
                                                     nav: 14.2656,
                                                     navDate: "2021-09-07T00:00:00.000Z",
                                                     avgReturn: 63.633823),
                    FundRankingModel.FundRankingData(mstarId: "F00000HHFC",
                                                     fundName: "KT-OIL",
                                                     navReturn: 73.33466,
                                                     nav: 3.4868,
                                                     navDate: "2021-09-03T00:00:00.000Z",
                                                     avgReturn: 65.394614)]
    let fundData = FundRanking.GetFundRankingList.Response.FundRankingData(periodOption: .year,
                                                                           fundList: fundList)
    let response = FundRanking.GetFundRankingList.Response(result: .success(result: fundData))
    
    // When
    presenter.presentFundRanking(response: response)
    
    // Then
    XCTAssertTrue(viewcontrollerSpy.displayFundRankingCalled, "presentFundRanking() should call displayFundRanking()")
    switch viewcontrollerSpy.displayFundRankingViewModel.content {
    case .success(let data):
      XCTAssertEqual(data.first?.fundName, "PRINCIPAL VNEQ-A")
    case .failure:
      XCTFail("This case should be success")
    }
  }
  
  func testPresentFundRankingCaseSuccessAndHaveFavList() {
    // Given
    let fundList = [FundRankingModel.FundRankingData(mstarId: "F00000ZMXD",
                                                     fundName: "PRINCIPAL VNEQ-A",
                                                     navReturn: 74.80117,
                                                     nav: 14.154,
                                                     navDate: "2021-09-07T00:00:00.000Z",
                                                     avgReturn: 63.633823),
                    FundRankingModel.FundRankingData(mstarId: "F0000109C9",
                                                     fundName: "PRINCIPAL VNEQ-I",
                                                     navReturn: 74.79997,
                                                     nav: 14.2656,
                                                     navDate: "2021-09-07T00:00:00.000Z",
                                                     avgReturn: 63.633823),
                    FundRankingModel.FundRankingData(mstarId: "F00000HHFC",
                                                     fundName: "KT-OIL",
                                                     navReturn: 73.33466,
                                                     nav: 3.4868,
                                                     navDate: "2021-09-03T00:00:00.000Z",
                                                     avgReturn: 65.394614)]
    let favList = FundViewModel(fundName: "PRINCIPAL VNEQ-A",
                                nav: 14.154,
                                navReturn: 74.80117,
                                navDate: "2021-09-07T00:00:00.000Z",
                                avgReturn: 63.633823,
                                isFav: true,
                                optionReturn: .year,
                                mstarId: "F00000ZMXD")
    ServiceManager.shared().setFavFundToDatabase(favFund: favList)
    let fundData = FundRanking.GetFundRankingList.Response.FundRankingData(periodOption: .year,
                                                                           fundList: fundList)
    let response = FundRanking.GetFundRankingList.Response(result: .success(result: fundData))
    
    // When
    presenter.presentFundRanking(response: response)
    
    // Then
    XCTAssertTrue(viewcontrollerSpy.displayFundRankingCalled, "presentFundRanking() should call displayFundRanking()")
    switch viewcontrollerSpy.displayFundRankingViewModel.content {
    case .success(let data):
      XCTAssertEqual(data.first?.fundName, "PRINCIPAL VNEQ-A")
      XCTAssertEqual(data.first?.isFav, true)
    case .failure:
      XCTFail("This case should be success")
    }
    ServiceManager.shared().removeFavDataInFavListFromUserDefault(mstarId: favList.mstarId)
  }
  
  func testPresentFundRankingCaseFailure() {
    // Given
    let response = FundRanking.GetFundRankingList.Response(result: .failure(error: .invalidData))
    
    // When
    presenter.presentFundRanking(response: response)
    
    // Then
    XCTAssertTrue(viewcontrollerSpy.displayFundRankingCalled, "presentFundRanking() should call displayFundRanking()")
    switch viewcontrollerSpy.displayFundRankingViewModel.content {
    case .success:
      XCTFail("This case should be failure")
    case .failure(let error):
      XCTAssertEqual(error as! APIError, APIError.invalidData)
    }
  }
}
