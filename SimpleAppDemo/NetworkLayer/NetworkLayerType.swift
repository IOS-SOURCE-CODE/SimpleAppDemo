//
//  NetworkLayerType.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/22/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkLayerType {
   //   var baseURL : URL { get }
   //   var session: URLSession { get }
   //   var resource: URLConfigurationType { get }
   func request() -> Observable<Data?>
   func response(request: URLRequest) -> Observable<Data?>
}
