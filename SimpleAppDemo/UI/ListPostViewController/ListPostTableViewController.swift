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

class ListPostTableViewController: UITableViewController, BindableType {
   
   var viewModel: ListPostViewModel!
   private let bag = DisposeBag()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // View Controller appearance setup
      setupAppearance()
      
    
      setupTableView()
      
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
      tableView.register(ListPostTableViewCell.self)
      tableView.estimatedRowHeight = 320
      tableView.rowHeight = UITableViewAutomaticDimension
   }
}


extension ListPostTableViewController {
   func bindViewModel() {
      
//      viewModel.posts.asObservable()
//         .bind(to: tableView.rx.items(cellIdentifier: ListPostTableViewCell.identifier, cellType: ListPostTableViewCell.self))
//         { index, model, cell in
//
//            debugPrint(model)
//
//         }.disposed(by: self.rx.disposeBag)
      
      viewModel.posts.asDriver()
         .drive(onNext: { posts in
            debugPrint(posts)
         }).disposed(by: bag)
//      viewModel.posts.asObservable().subscribe(onNext: { posts in
//         debugPrint(posts)
//      }).disposed(by: bag)
   }
}








