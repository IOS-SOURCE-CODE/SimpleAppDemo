//
//  ViewController.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit

class ListPostTableViewController: UITableViewController, BindableType {
   
   var viewModel: ListPostViewModel!
   
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
      
   }
}
