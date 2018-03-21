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
   var isLoading = false
  
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
      
      
      ReachabilityManager.shared.isConnected
         .subscribe(onNext: { [weak self] value in
            self?.isLoading = value
         }).disposed(by: bag)
      
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
      self.tableView.delegate = self
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
      
      guard isLoading else {
          refresher.endRefreshing()
         return
      }
      
      viewModel.fetchPosts(isOnline: isLoading)
     
   }
}


extension ListPostTableViewController {
   func bindViewModel() {
      
      viewModel.posts.asDriver()
         .filter { [weak self] _ in
            if self?.isLoading == false {
               self?.loadingView.stopAnimating()
            }
            return (self?.isLoading)!
         }
         .do(onNext: { [weak self] posts in
            guard posts.count > 0 else { return }
            self?.tableView.isHidden = false
            self?.loadingView.stopAnimating()
            self?.refresher.endRefreshing()
         })
         .drive(tableView.rx.items(cellIdentifier: ListPostTableViewCell.identifier, cellType:  ListPostTableViewCell.self)) { index, model, cell in
            
            cell.configure(with: model)
            
         }.disposed(by: self.rx.disposeBag)
      
   }
}

extension ListPostTableViewController: UITableViewDelegate {

   
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
      
      let scrollViewHeight = scrollView.frame.size.height
      let scrollViewContentSize = scrollView.contentSize.height
      let contentLarger = (scrollViewContentSize > scrollViewHeight)
      
      let viewableHeight = contentLarger ? scrollViewHeight : scrollViewContentSize
      
      let loadable = (scrollView.contentOffset.y >= scrollView.contentSize.height - viewableHeight + 50)
      
      if loadable {
         guard isLoading else { return }
         viewModel.fetchMorePage()
      }
   }

}






