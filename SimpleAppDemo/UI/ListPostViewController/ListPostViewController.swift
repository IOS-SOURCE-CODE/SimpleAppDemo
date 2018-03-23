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
import RxDataSources

class ListPostViewController: UIViewController, BindableType {
   
   var viewModel: ListPostViewModel!
   private let bag = DisposeBag()
   fileprivate var tableView: UITableView!
   fileprivate var isLoading = false
  
  var dataSource: RxTableViewSectionedAnimatedDataSource<PostSection>!
  
  
  
  fileprivate func configureDataSource()  {
    dataSource = RxTableViewSectionedAnimatedDataSource<PostSection>(configureCell: { (dataSource, tableview, indexPath, item) -> UITableViewCell in
      
      let cell: ListPostTableViewCell = tableview.deqeueReusableCell(for: indexPath)
      cell.configure(with: item)
      
      return cell
    })
  }
  
  
  fileprivate lazy var loadingView:UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    activityIndicator.hidesWhenStopped = true
    return activityIndicator
    
  }()
  
  fileprivate lazy var refresher:UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    refreshControl.addTarget(self, action: #selector(self.refreshing), for: .valueChanged)
    return refreshControl
  }()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // View Controller appearance setup
      setupAppearance()
    
    
      setupTableView()
      tableView.addSubview(refresher)
    
     setupLoadingView()
      
      ReachabilityManager.shared.isConnected
         .subscribe(onNext: { [weak self] value in
            self?.isLoading = value
         }).disposed(by: bag)
    
      configureDataSource()
      
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
      tableView = UITableView(frame: self.view.frame)
      view.addSubview(tableView)
      tableView.register(ListPostTableViewCell.self)
      tableView.rowHeight = 500
      tableView.separatorStyle = .none
    
   }
  fileprivate func setupLoadingView() {
    loadingView.center = self.view.center
    self.view.addSubview(loadingView)
    loadingView.startAnimating()
  }
  
   @objc fileprivate func refreshing() {
    
      guard isLoading else {
          refresher.endRefreshing()
         return
      }
      viewModel.loadData()
   }
}


extension ListPostViewController {
   func bindViewModel() {
      
//      viewModel.posts.asDriver()
//         .do(onNext: { [weak self] posts in
//            guard posts.count > 0 else { return }
//            self?.loadingView.stopAnimating()
//            self?.refresher.endRefreshing()
//         })
//         .drive(tableView.rx.items(cellIdentifier: ListPostTableViewCell.identifier, cellType:  ListPostTableViewCell.self)) { index, model, cell in
//            cell.configure(with: model)
//
//         }
//        .disposed(by: self.rx.disposeBag)
    
    
    viewModel.posts.asDriver()
      .do(onNext: { [weak self] posts in
          guard posts.count > 0 else { return }
          self?.loadingView.stopAnimating()
          self?.refresher.endRefreshing()
       })
      .drive(tableView.rx.items(dataSource: dataSource))
      .disposed(by: self.rx.disposeBag)
    
//    tableView.rx.itemSelected
//      .do(onNext: { [unowned self] indexPath in
//        self.tableView.deselectRow(at: indexPath, animated: false)
//      })
//      .map { [unowned self] indexPath -> Post in
//        return self.viewModel.posts.value[indexPath.row]
//      }
//      .subscribe(viewModel.detailAction.inputs)
//      .disposed(by: self.rx.disposeBag)
  
   
   tableView.rx.didEndDragging
    .withLatestFrom(tableView.rx.contentOffset)
    .map { [unowned self] scrollView -> CGFloat in
      return self.isReachBottom(with: scrollView)
    }
    .subscribe(onNext: { [weak self] value in
      if Int(value) < 10 {
        self?.viewModel.fetchMorePage()
        self?.tableView.endUpdates()
      }
   }).disposed(by: self.rx.disposeBag)
    
  }
}

// MARK: -  Helper
extension ListPostViewController {
  
  fileprivate func isReachBottom(with scrollView: CGPoint) -> CGFloat {
    let currentOffset = scrollView.y
    let maximumOffset = tableView.contentSize.height - tableView.frame.size.height
    return maximumOffset - currentOffset
  }
}
