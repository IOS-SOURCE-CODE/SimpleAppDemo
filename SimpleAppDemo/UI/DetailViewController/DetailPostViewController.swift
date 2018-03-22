//
//  DetailPostViewController.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit

class DetailPostViewController: UIViewController, BindableType {
   
   var viewModel: DetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
      
      view.backgroundColor = .white
      
    }


}

extension DetailPostViewController {
   func bindViewModel() {
      
   }
}
