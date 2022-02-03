//
//  FundRankingViewController.swift
//  TestFinomena
//
//  Created by ADINAN YUJAROEN on 2/2/2565 BE.
//  Copyright (c) 2565 BE ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol FundRankingViewControllerInterface: AnyObject {
  func displayFundRanking(viewModel: FundRanking.GetFundRankingList.ViewModel)
}

class FundRankingViewController: UIViewController, FundRankingViewControllerInterface {
  var interactor: FundRankingInteractorInterface!
  var router: FundRankingRouter!
  
  var fundList: [FundViewModel] = []
  
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var segment: UISegmentedControl!
  
  // MARK: - Object lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
  // MARK: - Configuration
  
  private func configure(viewController: FundRankingViewController) {
    let router = FundRankingRouter()
    router.viewController = viewController
    
    let presenter = FundRankingPresenter()
    presenter.viewController = viewController
    
    let interactor = FundRankingInteractor()
    interactor.presenter = presenter
    
    interactor.worker = FundRankingWorker(store: FundRankingStore())
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
    getFundRankingList(periodOption: .day)
    segment.selectedSegmentIndex = 0
  }
  
  private func setDelegate() {
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  private func getFundRankingList(periodOption: PeriodOption) {
    ServiceManager.shared().showLoader(view: view)
    let request = FundRanking.GetFundRankingList.Request(periodOption: periodOption)
    interactor.getFundRankingList(request: request)
  }
  
  // MARK: - Event handling
  
  @IBAction func switchChange(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0:
      // 1D
      getFundRankingList(periodOption: .day)
    case 1:
      // 1W
      getFundRankingList(periodOption: .week)
    case 2:
      // 1M
      getFundRankingList(periodOption: .month)
    case 3:
      // 1Y
      getFundRankingList(periodOption: .year)
    default:
      print("default")
    }
  }
  
  // MARK: - Display logic
  func displayFundRanking(viewModel: FundRanking.GetFundRankingList.ViewModel) {
    ServiceManager.shared().stopLoader()
    switch viewModel.content {
    case .success(let data):
      fundList = data
      tableView.reloadData()
    case .failure(let error):
      print(error)
    }
  }
  // MARK: - Router
  
}

extension FundRankingViewController: UITableViewDataSource, UITableViewDelegate {
  private func setupTableViewCell() {
    let nibName = UINib(nibName: FundViewCell.identifier, bundle: nil)
    tableView.register(nibName, forCellReuseIdentifier: FundViewCell.identifier)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fundList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: FundViewCell.identifier, for: indexPath) as? FundViewCell else {
      return UITableViewCell()
    }
    cell.updateUI(viewModel: fundList[indexPath.row])
    return cell
  }
}
