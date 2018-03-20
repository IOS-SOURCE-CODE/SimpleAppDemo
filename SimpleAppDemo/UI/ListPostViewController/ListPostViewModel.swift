//
//  ListPostViewModel.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation
import RxSwift

class ListPostViewModel: ViewModelType {
   
   
   // MARK - Constrant
    let bag = DisposeBag()
   
   
   // MAKR: - Output
   
   
   
   // MARK: - Init
   let sceneCoordinator: SceneCoordinatorType
   let network: NetworkLayerType
   let translation: TranslationLayerType
   
   init(sceneCoordinator: SceneCoordinatorType, network: NetworkLayerType, translation: TranslationLayerType) {
      self.sceneCoordinator = sceneCoordinator
      self.network = network
      self.translation = translation
      
      loadData()
   }
   
   fileprivate func loadData() {
      
   }
}
