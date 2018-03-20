//
//  ViewController.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit
import RxSwift
import NSObject_Rx
import RxCocoa

class ListPostTableViewController: UIViewController, BindableType {
   
   var viewModel: ListPostViewModel!
   private let bag = DisposeBag()
   var tableView: UITableView!
  var isLoading = Observable.just(true)
  
  lazy var loadingView:UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    activityIndicator.hidesWhenStopped = true
    return activityIndicator
    
  }()
  
  lazy var refresher:UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    refreshControl.addTarget(self, action: #selector(self.refreshing), for: .valueChanged)
    return refreshControl
  }()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // View Controller appearance setup
      setupAppearance()
    
      setupLoadingView()
      setupTableView()
      tableView.addSubview(refresher)
    
      
   }
  
  
   
   //MARK: - Setup View appearance
   fileprivate func setupAppearance() {
      view.backgroundColor = .white
      self.navigationItem.title = "Instagram"
      let leftButtonItem = UIBarButtonItem(image: UIImage(named: "camera"), style: .done, target: nil, action: nil)
      let rightButtonItem = UIBarButtonItem(image: UIImage(named: "share"), style: .done, target: nil, action: nil)
      self.navigationItem.leftBarButtonItem = leftButtonItem
      self.navigationItem.rightBarButtonItem = rightButtonItem
      self.navigationItem.leftBarButtonItem?.tintColor = .black
      self.navigationItem.rightBarButtonItem?.tintColor = .black
      
   }
   
    //MARK: - Setup Tableview appearance
   fileprivate func setupTableView() {
      tableView = UITableView(frame: self.view.bounds)
      self.view.addSubview(tableView)
      tableView.register(ListPostTableViewCell.self)
//      tableView.estimatedRowHeight = 320
      tableView.rowHeight = 455
    tableView.separatorStyle = .none
    tableView.isHidden = true
    
   }
  fileprivate func setupLoadingView() {
    loadingView.center = self.view.center
    self.view.addSubview(loadingView)
    loadingView.startAnimating()
  }
  
  @objc func refreshing() {
    viewModel.loadData()
  }
}


extension ListPostTableViewController {
   func bindViewModel() {
    
    viewModel.posts.asDriver()
      .do(onNext: { [weak self] posts in
        guard posts.count > 0 else { return }
        self?.tableView.isHidden = false
        self?.loadingView.stopAnimating()
        self?.refresher.endRefreshing()
      })
      .drive(tableView.rx.items(cellIdentifier: ListPostTableViewCell.identifier, cellType:  ListPostTableViewCell.self)) { index, model, cell in
        cell.configure(with: model)
        debugPrint("table view \(model)" )
      }.disposed(by: self.rx.disposeBag)
   }
}








