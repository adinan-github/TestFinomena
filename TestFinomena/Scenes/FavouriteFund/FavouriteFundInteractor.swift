//
//  FavouriteFundInteractor.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 2/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FavouriteFundInteractorInterface {
  func getFavList(request: FavouriteFund.GetFavList.Request)
}

class FavouriteFundInteractor: FavouriteFundInteractorInterface {
  var presenter: FavouriteFundPresenterInterface!


  // MARK: - Business logic
  func getFavList(request: FavouriteFund.GetFavList.Request) {
    let favList = ServiceManager.shared().getFavListFromDatabase()
    let response = FavouriteFund.GetFavList.Response(favList: favList)
    presenter.presentFavList(response: response)
  }
}
