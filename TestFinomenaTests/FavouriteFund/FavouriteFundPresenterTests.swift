//
//  FavouriteFundPresenterTests.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 3/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import TestFinomena
import XCTest

class FavouriteFundPresenterTests: XCTestCase {

  // MARK: - Subject under test

  var presenter: FavouriteFundPresenter!
  var viewControllerSpy: FavouriteFundViewControllerSpy!
  
  class FavouriteFundViewControllerSpy: FavouriteFundViewControllerInterface {
    var displayFavListCalled: Bool = false
    var displayFavListViewModel: FavouriteFund.GetFavList.ViewModel!
    
    func displayFavList(viewModel: FavouriteFund.GetFavList.ViewModel) {
      displayFavListCalled = true
      displayFavListViewModel = viewModel
    }
  }

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupFavouriteFundPresenter()
  }

  // MARK: - Test setup
  func setupFavouriteFundPresenter() {
    presenter = FavouriteFundPresenter()
    
    viewControllerSpy = FavouriteFundViewControllerSpy()
    presenter.viewController = viewControllerSpy
  }

  func testPresentFavList() {
    // Given
    let favList = [FundViewModel(fundName: "PRINCIPAL VNEQ-A",
                                nav: 14.154,
                                navReturn: 74.80117,
                                navDate: "2021-09-07T00:00:00.000Z",
                                avgReturn: 63.633823,
                                isFav: true,
                                optionReturn: .year,
                                mstarId: "F00000ZMXD")]
    let response = FavouriteFund.GetFavList.Response(favList: favList)
    
    // When
    presenter.presentFavList(response: response)
    
    // Then
    XCTAssertTrue(viewControllerSpy.displayFavListCalled, "presentFavList() should ask to displayFavList()")
    XCTAssertEqual(viewControllerSpy.displayFavListViewModel.favList.first?.mstarId, "F00000ZMXD")
    XCTAssertEqual(viewControllerSpy.displayFavListViewModel.favList.first?.fundName, "PRINCIPAL VNEQ-A")
    XCTAssertEqual(viewControllerSpy.displayFavListViewModel.favList.first?.nav, 14.154)
    XCTAssertEqual(viewControllerSpy.displayFavListViewModel.favList.first?.navReturn, 74.80117)
    XCTAssertEqual(viewControllerSpy.displayFavListViewModel.favList.first?.navDate, "2021-09-07T00:00:00.000Z")
    XCTAssertEqual(viewControllerSpy.displayFavListViewModel.favList.first?.isFav, true)
    XCTAssertEqual(viewControllerSpy.displayFavListViewModel.favList.first?.optionReturn, .year)
  }
}
