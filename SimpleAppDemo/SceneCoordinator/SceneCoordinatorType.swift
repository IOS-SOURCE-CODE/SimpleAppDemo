//
//  SceneCoordinatorType.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit
import RxSwift

protocol SceneCoordinatorType: class {
  
  var currentViewController: UIViewController? { get set }
  
  init(window: UIWindow, mainViewController: UIViewController)
  
  @discardableResult
  func transition(to scene: Scene, type: SceneTransitionType) -> Completable
  
  @discardableResult
  func pop(animated: Bool) -> Completable
  
  
}

extension SceneCoordinatorType {
  
  @discardableResult
  func pop() -> Completable {
    return pop(animated: true)
  }
}
