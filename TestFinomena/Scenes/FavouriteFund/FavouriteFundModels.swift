//
//  FavouriteFundModels.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 2/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct FavouriteFund {
  
  struct GetFavList {
    
    struct Request {}
    
    struct Response {
      let favList: [FundViewModel]
    }
    
    struct ViewModel {
      let favList: [FundViewModel]
    }
  }
}
