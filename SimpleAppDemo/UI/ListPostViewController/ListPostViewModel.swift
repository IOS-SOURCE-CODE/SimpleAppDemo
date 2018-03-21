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
   
   
   // MARK - Internal Access
   private let bag = DisposeBag()
   private var isShouldFetch = true
   
   // MAKR: - Output
   var posts = Variable<[Post]>([])
   var pagination = Variable<Pagination?>(nil)
   
   // MARK: - Input
   let network: NetworkLayerType
   let translation: TranslationLayerType
   
   // MARK: - Init
   init(network: NetworkLayerType, translation: TranslationLayerType) {
      
      self.network = network
      self.translation = translation
      
      loadData()
   }
   
   func fetchMorePage() {
      
      guard let nextString = pagination.value?.nextUrl else { return }
      let nextUrl = URL(string: nextString)!
      let urlRequest = URLRequest(url: nextUrl)

      network.response(request: urlRequest).asObservable()
         .distinctUntilChanged()
         .map { [weak self] data  in
            guard let strongSelf = self else { return [] }
            guard let result: ListPost = strongSelf.translation.decode(data: data) else { return [] }
            strongSelf.pagination.value = result.pagination
            return result.data
         }.catchErrorJustReturn([])
         .subscribe(onNext: { newpost in
            self.posts.value.append(contentsOf: newpost as [Post])
         })
         .disposed(by: bag)
      
   }
   
   fileprivate func loadData() {
      ReachabilityManager.shared.isConnected
      .subscribe(onNext: { [weak self] value in
         self?.fetchPosts(isOnline: value)
      }).disposed(by: bag)
   }
   
   func fetchPosts(isOnline: Bool) {
      network.request()
         .asObservable()
         .filter { _ in return isOnline }
         .distinctUntilChanged()
         .do(onError: { (error) in
            debugPrint("error ======= \(error)")
         })
         .map { [weak self] data  in
            guard let strongSelf = self else { return [] }
            let result: ListPost = strongSelf.translation.decode(data: data)!
            strongSelf.pagination.value = result.pagination
            return result.data
         }.catchErrorJustReturn([])
         .bind(to: self.posts)
         .disposed(by: bag)
   }
}
