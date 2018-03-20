//
//  Like.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation

struct Like :Decodable {
   let count: Int
}

extension Like: JSONDecodable {
   init?(dictionary: JSONDictionary) {
      guard let count = dictionary["count"] as? Int else { return nil }
      self.count = count
   }
}
