//
//  Pagination.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation


struct Pagination : Decodable {
   var next_max_id: String?
   var next_url: String?
//
//   enum CodingKeys: String, CodingKey {
//
//      case nextMaxId = "next_max_id"
//      case nextUrl = "next_url"
//   }
//
//
//   init(from decoder: Decoder) throws {
//      if let values = try? decoder.container(keyedBy: CodingKeys.self) {
//         nextMaxId = try values.decode(String.self, forKey:.nextMaxId)
//         nextUrl = try values.decode(String.self, forKey: .nextUrl)
//      } else {
//         nextUrl = nil
//         nextMaxId = nil
//      }
   
}

extension Pagination: JSONDecodable {
   init?(dictionary: JSONDictionary) {
      guard let nextMaxId = dictionary["next_max_id"] as? String,
      let nextUrl = dictionary["next_url"] as? String else { return nil }
      
      self.next_url = nextUrl
      self.next_max_id = nextMaxId
   }
}
