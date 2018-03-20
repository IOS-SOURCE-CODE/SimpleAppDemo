//
//  NetworkLayer.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkLayerType {
   var baseURL : URL { get }
   var session: URLSession { get }
   var resource: URLConfigurationType { get }
   func request() -> Observable<Data>
}


final class NetworkLayer: NetworkLayerType {
   
   let baseURL : URL
   let session: URLSession
   let resource: URLConfigurationType
   
   init(baseURL: URL, urlRequest:URLConfigurationType, session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
      
      self.baseURL = baseURL
      self.session = session
      self.resource = urlRequest
   }
   
   func request() -> Observable<Data> {
      
      return Observable.create { [weak self] observer in
         
         guard let strongSelf = self else {
            fatalError("Cannot assess self from strong self in request")
         }
         
         let request = strongSelf.resource.urlRequest(baseURL: strongSelf.baseURL)
         
         let task = strongSelf.session.dataTask(with: request) { data, response, error in
            
            if let error = error {
               observer.onError(APIClientError.Other(error))
            } else {
               guard let HTTPResponse = response as? HTTPURLResponse else {
                  fatalError("Couldn't get HTTP response")
               }
               
               if 200 ..< 300 ~= HTTPResponse.statusCode {
                  observer.onNext(data!)
                  observer.onCompleted()
               } else{
                  observer.onError(APIClientError.BadStatus(status: HTTPResponse.statusCode))
               }
            }
         }
         
         task.resume()
         
         return Disposables.create(with: task.cancel)
         
         }
   }
   
}

