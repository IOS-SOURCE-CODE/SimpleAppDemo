//
//  ListPostViewModel.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation
import RxSwift
import Action

class ListPostViewModel {
   
   
   // MARK - Internal Access
   private let bag = DisposeBag()
   private var isShouldFetch = true
   let queue = DispatchQueue(label: "QueueWorkOnPagination")
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

  lazy var detailAction: Action<Post, Swift.Never> = {
    return Action { post in
      let detailViewModel = DetailViewModel(item: post)
      return SceneCoordinator.transition(to: .detail(viewModel: detailViewModel), type: .push).asObservable()
    }
  }()
  
   func fetchMorePage() {
      
      queue.async(flags: .barrier) { [weak self] in
         guard let nextString = self?.pagination.value?.next_url else { return }
         let nextUrl = URL(string: nextString)!
         let urlRequest = URLRequest(url: nextUrl)
         
         self?.network.response(request: urlRequest).asObservable()
            .distinctUntilChanged()
            .map { [weak self] data  in
               guard let strongSelf = self else { return [] }
               guard let result: ListPost = strongSelf.translation.decode(data: data) else { return [] }
               strongSelf.pagination.value = result.pagination
               return result.data
            }.catchErrorJustReturn([])
            .subscribe(onNext: { newpost in
               self?.posts.value.append(contentsOf: newpost as [Post])
            })
            .disposed(by: (self?.bag)!)
      }
      
     
      
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
