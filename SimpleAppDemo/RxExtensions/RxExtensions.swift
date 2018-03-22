//
//  RxExtensions.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/22/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension ObservableType where E: Sequence, E.Iterator.Element: Equatable {
   func distinctUntilChanged() -> Observable<E> {
      return distinctUntilChanged { (lhs, rhs) -> Bool in
         return Array(lhs) == Array(rhs)
      }
   }
}


//extension Reactive where Base: UIScrollView {
//   var reachedBottom: ControlEvent<Void> {
//      let observable = contentOffset
//         .flatMap { [weak base] contentOffset -> Observable<Void> in
//            guard let scrollView = base else {
//               return Observable.empty()
//            }
//            
//            let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
//            let y = contentOffset.y + scrollView.contentInset.top
//            let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)
//            
////            return y > threshold ? Observable.just(_) : Observable.empty()
//            return Observable.empty()
//      }
//      
//      return ControlEvent(events: observable)
//   }
//}

