//
//  FavouriteFundPresenter.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 2/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FavouriteFundPresenterInterface {
  func presentFavList(response: FavouriteFund.GetFavList.Response)
}

class FavouriteFundPresenter: FavouriteFundPresenterInterface {
  weak var viewController: FavouriteFundViewControllerInterface!

  // MARK: - Presentation logic
  func presentFavList(response: FavouriteFund.GetFavList.Response) {
    let viewModel = FavouriteFund.GetFavList.ViewModel(favList: response.favList)
    viewController.displayFavList(viewModel: viewModel)
  }
}
