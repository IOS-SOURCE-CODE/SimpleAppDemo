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


class ListPostViewController: UIViewController, BindableType {
   
   var viewModel: ListPostViewModel!
   private let bag = DisposeBag()
   fileprivate var tableView: UITableView!
   fileprivate var isLoading = false
  
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
      tableView = UITableView(frame: self.view.frame)
      view.addSubview(tableView)
      tableView.register(ListPostTableViewCell.self)
      tableView.delegate = self
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
      
      viewModel.posts.asDriver()
         .do(onNext: { [weak self] posts in
            guard posts.count > 0 else { return }
            self?.loadingView.stopAnimating()
            self?.refresher.endRefreshing()
         })
         .drive(tableView.rx.items(cellIdentifier: ListPostTableViewCell.identifier, cellType:  ListPostTableViewCell.self)) { index, model, cell in
            cell.configure(with: model)
            
         }.disposed(by: self.rx.disposeBag)
    
    tableView.rx.itemSelected
      .do(onNext: { [unowned self] indexPath in
        self.tableView.deselectRow(at: indexPath, animated: false)
      })
      .map { [unowned self] indexPath -> Post in
        return self.viewModel.posts.value[indexPath.row]
      }
      .subscribe(viewModel.detailAction.inputs)
      .disposed(by: self.rx.disposeBag)
   
      
      tableView.rx.didEndDragging
      .map { [weak self] _ -> Bool in
         
         let currentOffset = self?.tableView.rx.contentOffset.map { $0.y }
//         scrollView.contentOffset.y
//            let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
//
//            if maximumOffset - currentOffset <= 10.0 {
//              return true
//            }
         return false
      }
      .subscribe(onNext: { value in
         print("didEndDragging \(value)")
      }).disposed(by: self.rx.disposeBag)
      
//      tableView.rx.didEndDecelerating
//         .subscribe(onNext: { value in
//            print("didEndDecelerating \(value)")
//         }).disposed(by: self.rx.disposeBag)
   }
}

extension ListPostViewController: UITableViewDelegate {

//   func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//
//      let currentOffset = scrollView.contentOffset.y
//      let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
//
//      if maximumOffset - currentOffset <= 10.0 {
//         viewModel.fetchMorePage()
//      }
//  }
   
   func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      debugPrint("scrollViewDidEndDecelerating")
   }
   
   
  
   
   func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      
     
      
      
   }

}


extension UIScrollView {
   func  isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
      return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
   }
}





