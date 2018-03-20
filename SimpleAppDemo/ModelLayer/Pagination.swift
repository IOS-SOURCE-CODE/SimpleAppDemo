//
//  Pagination.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation


struct Pagination : Decodable {
   let nextMaxId: String
   let nextUrl: String
   
   enum CodingKeys: String, CodingKey {
      case nextMaxId = "next_max_id"
      case nextUrl = "next_url"
   }
   
}

extension Pagination: JSONDecodable {
   init?(dictionary: JSONDictionary) {
      guard let nextMaxId = dictionary["next_max_id"] as? String,
      let nextUrl = dictionary["next_url"] as? String else { return nil }
      
      self.nextUrl = nextUrl
      self.nextMaxId = nextMaxId
   }
}
