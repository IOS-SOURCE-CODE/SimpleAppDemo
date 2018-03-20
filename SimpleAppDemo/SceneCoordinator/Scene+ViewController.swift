//
//  Scene+ViewController.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit


extension Scene {
  
  func viewController() -> UIViewController {
    
    switch self {
      
    case .home(let viewModel):
      var listPost = ListPostTableViewController()
  
      listPost.bindViewModel(to: viewModel)
      return listPost
      
    case .detail(let viewModel):
         var detail = DetailPostViewController()
         detail.bindViewModel(to: viewModel)
         return detail
    }
  }
  
}
