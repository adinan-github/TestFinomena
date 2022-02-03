//
//  FavouriteFundViewController.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 2/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FavouriteFundViewControllerInterface: AnyObject {
  func displayFavList(viewModel: FavouriteFund.GetFavList.ViewModel)
}

class FavouriteFundViewController: UIViewController, FavouriteFundViewControllerInterface {
  var interactor: FavouriteFundInteractorInterface!
  var router: FavouriteFundRouter!
  
  var favouriteList: [FundViewModel] = []
  
  @IBOutlet private weak var tableView: UITableView!

  // MARK: - Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }

  // MARK: - Configuration

  private func configure(viewController: FavouriteFundViewController) {
    let router = FavouriteFundRouter()
    router.viewController = viewController

    let presenter = FavouriteFundPresenter()
    presenter.viewController = viewController

    let interactor = FavouriteFundInteractor()
    interactor.presenter = presenter

    viewController.interactor = interactor
    viewController.router = router
  }

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setDelegate()
    setupTableViewCell()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getFavList()
  }
  
  private func setDelegate() {
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  private func getFavList() {
    let request = FavouriteFund.GetFavList.Request()
    interactor.getFavList(request: request)
  }

  // MARK: - Event handling

  // MARK: - Display logic
  func displayFavList(viewModel: FavouriteFund.GetFavList.ViewModel) {
    favouriteList = viewModel.favList
    tableView.reloadData()
  }
  // MARK: - Router

}

extension FavouriteFundViewController: UITableViewDataSource, UITableViewDelegate {
  private func setupTableViewCell() {
    let nibName = UINib(nibName: FundViewCell.identifier, bundle: nil)
    tableView.register(nibName, forCellReuseIdentifier: FundViewCell.identifier)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favouriteList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: FundViewCell.identifier, for: indexPath) as? FundViewCell else {
      return UITableViewCell()
    }
    cell.delegate = self
    cell.setHideOptionReturnView(isFromFav: true)
    cell.updateUI(viewModel: favouriteList[indexPath.row])
    return cell
  }
}

extension FavouriteFundViewController: FundViewCellProtocol {
  func unFavCell(id: String) {
    ServiceManager.shared().removeFavDataInFavListFromUserDefault(mstarId: id)
    getFavList()
  }
}
