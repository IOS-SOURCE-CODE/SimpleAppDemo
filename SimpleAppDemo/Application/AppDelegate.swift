//
//  AppDelegate.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   
   var window: UIWindow?
  
   var dependencyRegistry: DependencyRegistry!
   
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      
      window = UIWindow(frame: UIScreen.main.bounds)
    
      
      // MARK: Change endpoint production or development
      EndPoint.active = EndPointConfiguration.production.active
      
      dependencyRegistry = DependencyRegistry()
      SceneCoordinator.window = window
      let viewModel = dependencyRegistry.resolver.resolve(ListPostViewModel.self)!
      SceneCoordinator.transition(to: .home(viewModel: viewModel), type: .root)
      
      return true
   }
   
   
   func applicationWillResignActive(_ application: UIApplication) {
      
   }
   
   func applicationDidEnterBackground(_ application: UIApplication) {
      
   }
   
   func applicationWillEnterForeground(_ application: UIApplication) {
      
   }
   
   func applicationDidBecomeActive(_ application: UIApplication) {
      
   }
   
   func applicationWillTerminate(_ application: UIApplication) {
      
   }
   
   
}

