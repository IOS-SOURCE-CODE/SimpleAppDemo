//
//  EndPointConfiguration.swift
//  EcommerceShopping
//
//  Created by Hiem Seyha on 3/17/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation

// EndPoint Manager

struct EndPoint: EndPointConfigurationActiveType {
   
   private typealias me = EndPoint
   
   static var active: String!
   
   enum Post: String {
      case get
      
      public var value: String {
         switch self {
         case .get:
            return me.active + "users/7322641520/media/recent"
         }
      }
   }
}

