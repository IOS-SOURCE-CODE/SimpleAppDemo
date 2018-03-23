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
import RxDataSources

typealias PostSection = AnimatableSectionModel<String, Post>

class ListPostViewModel {
   
   
   // MARK - Internal Access
   private let bag = DisposeBag()
   private var isShouldFetch = true
    private let emptyResult = PostSection(model: "", items: [])

   // MAKR: - Output
   var posts = Variable<[PostSection]>([])
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
      let detailViewModel = DetailViewModel(item: [post])
      return SceneCoordinator.transition(to: .detail(viewModel: detailViewModel), type: .push).asObservable()
    }
  }()
  
   func fetchMorePage() {
      //TODO: Fix this stuff
      guard let nextUrl = self.pagination.value?.next_url else { return }
      
      let urlRequest = URLRequest(url: nextUrl)
      
      self.network.response(request: urlRequest).asObservable()
         .map { [weak self] data  in
            self?.responseJSON(with: data)
         }
//         .map {  [weak self] newpost in
//          guard let result = newpost else { return [(self?.emptyResult)!] }
//
//          let postSection = result
//          let results =   self?.posts.value.append(postSection)
//
//
//
//         }
//         .distinctUntilChanged()
//         .catchErrorJustReturn([])
//         .bind(to: self.posts)
        
        .subscribe(onNext:{ [weak self] v in
          guard let result = v else { return }
          let newarray = [result]
          self?.posts.value.append(contentsOf: newarray)
        })
         .disposed(by: self.bag)
   }
   
   
   func loadData() {
      
      ReachabilityManager.shared.isConnected
         .subscribe(onNext: { value in
            if value { request() }
         }).disposed(by: bag)
      
      func request() {
         network.request()
            .asObservable()
            .map { [weak self] data  in
               guard let strongSelf = self else { return [PostSection(model:"", items:[])] }
               let result = strongSelf.responseJSON(with: data)
                return [result]
            }
//            .distinctUntilChanged()
            .catchErrorJustReturn([])
            .bind(to: self.posts)
            .disposed(by: bag)
      }
   }
   
}

//MARK: - Helper
extension ListPostViewModel {
   
   fileprivate func responseJSON(with data: Data?) -> PostSection {
    guard let responseData = data else { return emptyResult }
      guard let result: ListPost = self.translation.decode(data: responseData) else { return emptyResult }
      self.pagination.value = result.pagination
    
      let postSection = PostSection(model: "", items:result.data)
      return postSection
   }
}


