//
//  DependencyRegistry.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation
import Swinject

class HomeVCAssembly: Assembly {
  
  func assemble(container: Container) {
    
    // Register ViewController calling
    registerViewModel(container: container)
    
    
    // Register ViewModel calling
    registerViewModel(container: container)
   
   
   // Register layer calling
    registerLayer(container: container)
    
  }
  
  //MARK: - Register ViewController implementation
  fileprivate func registerViewController(container:Container) {
   
  }
  
  //MARK: - Register ViewModel implementation
  fileprivate func registerViewModel(container:Container) {
    
   container.register(ListPostViewModel.self) { r in
      
      let network = r.resolve(NetworkLayerType.self)!
      let translation = r.resolve(TranslationLayerType.self)!
      
      let viewModel = ListPostViewModel(network: network, translation: translation)
      return viewModel
   }.inObjectScope(.weak)
   
   
    
  }
   
   
   //MARK: - Register layer implementation
   fileprivate func registerLayer(container:Container) {
      
      container.register(TranslationLayerType.self) { _ in
         return TranslationLayer()
      }.inObjectScope(.weak)
      
      container.register(NetworkLayerType.self) { r in
         
         let baseURL = URL(string: EndPoint.active)!
         let paramater:[String:Any] = [HTTPParameter.accessToken:  Authentication.apiKey, HTTPParameter.count: 5]
         let urlRequest = GetURLRequest(path: EndPoint.Post.get.value, parameters: paramater)
         
         let network = NetworkLayer(baseURL: baseURL, urlRequest: urlRequest)
         
         return network
         
      }.inObjectScope(.weak)
      
   }
  
}
