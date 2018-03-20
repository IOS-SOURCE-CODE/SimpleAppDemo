//
//  ListPostViewModel.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation
import RxSwift

class ListPostViewModel {
   
   
   // MARK - Constrant
    private let bag = DisposeBag()
   
   
   // MAKR: - Output
   var posts = Variable<[Post]>([])
   
   
   // MARK: - Input
   let network: NetworkLayerType
   let translation: TranslationLayerType
   
    // MARK: - Init
   init(network: NetworkLayerType, translation: TranslationLayerType) {
      
      self.network = network
      self.translation = translation
      
      loadData()
   }
   
   fileprivate func loadData() {
      
      network.request()
         .distinctUntilChanged()
         .map { [weak self] data  in
            guard let strongSelf = self else { return [] }
             let result: ListPost = strongSelf.translation.decode(data: data)!
            return result.data
         }.bind(to: self.posts)
         .disposed(by: bag)
      
   }
}
