//
//  FavouriteFundInteractorTests.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 3/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import TestFinomena
import XCTest

class FavouriteFundInteractorTests: XCTestCase {

  // MARK: - Subject under test

  var interactor: FavouriteFundInteractor!
  var presenterSpy: FavouriteFundPresenterSpy!
  
  class FavouriteFundPresenterSpy: FavouriteFundPresenterInterface {
    var presentFavListCalled: Bool = false
    var presentFavListResponse: FavouriteFund.GetFavList.Response!
    
    func presentFavList(response: FavouriteFund.GetFavList.Response) {
      presentFavListCalled = true
      presentFavListResponse = response
    }
  }

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupFavouriteFundInteractor()
  }

  // MARK: - Test setup

  func setupFavouriteFundInteractor() {
    interactor = FavouriteFundInteractor()
    
    presenterSpy = FavouriteFundPresenterSpy()
    interactor.presenter = presenterSpy
  }

  // MARK: - Test doubles

  // MARK: - Tests

  func testGetFavList() {
    // Given
    let request = FavouriteFund.GetFavList.Request()
    let favList = FundViewModel(fundName: "PRINCIPAL VNEQ-A",
                                nav: 14.154,
                                navReturn: 74.80117,
                                navDate: "2021-09-07T00:00:00.000Z",
                                avgReturn: 63.633823,
                                isFav: true,
                                optionReturn: .year,
                                mstarId: "F00000ZMXD")
    ServiceManager.shared().setFavFundToDatabase(favFund: favList)
    
    // When
    interactor.getFavList(request: request)
    // Then
    XCTAssertTrue(presenterSpy.presentFavListCalled, "getFavList() should ask to presentFavList()")
    XCTAssertEqual(presenterSpy.presentFavListResponse.favList.first?.mstarId, "F00000ZMXD")
    XCTAssertEqual(presenterSpy.presentFavListResponse.favList.first?.fundName, "PRINCIPAL VNEQ-A")
    XCTAssertEqual(presenterSpy.presentFavListResponse.favList.first?.nav, 14.154)
    XCTAssertEqual(presenterSpy.presentFavListResponse.favList.first?.navReturn, 74.80117)
    XCTAssertEqual(presenterSpy.presentFavListResponse.favList.first?.navDate, "2021-09-07T00:00:00.000Z")
    XCTAssertEqual(presenterSpy.presentFavListResponse.favList.first?.isFav, true)
    XCTAssertEqual(presenterSpy.presentFavListResponse.favList.first?.optionReturn, .year)
  }
}
