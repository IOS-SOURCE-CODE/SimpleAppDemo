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
   
   
   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      
      window = UIWindow(frame: UIScreen.main.bounds)
    
      
      // MARK: Change endpoint production or development
      EndPoint.active = EndPointConfiguration.production.active
      
     
      
      let url = URL(string: EndPoint.Post.get.value)!
      let paramater = [HTTPHeaderField.acceptType.rawValue:  Authentication.apiKey]
      let urlRequest = GetURLRequest(path: EndPoint.Post.get.value, parameters: paramater)
      let network = NetworkLayer(baseURL: url, urlRequest: urlRequest)
      let translation = TranslationLayer()
      
      let viewController = ListPostTableViewController()
      
      let navigation = MainNavigationController(rootViewController: viewController)
      
      let scene = SceneCoordinator(window: window!, navigation: navigation)
      
      navigation.sceneCoordinator = scene
      
      
      let viewModel = ListPostViewModel(sceneCoordinator: scene, network: network, translation: translation)
      
      scene.transition(to: .home(viewModel: viewModel), type: .home)
      

      
      
      
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

