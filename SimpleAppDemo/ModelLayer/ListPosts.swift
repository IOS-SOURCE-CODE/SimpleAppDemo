//
//  ListPosts.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation

struct ListPost: Decodable {
   var data: [Post]
   var pagination: Pagination?
   
   enum CodingKeys: String, CodingKey {
      case data
      case pagination
   }
   
   init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      data = try values.decode([Post].self, forKey: .data)
      if let prepagination = try? values.decode(Pagination.self, forKey: .pagination)  {
        self.pagination = prepagination
      } else {
         pagination?.next_max_id = nil
         pagination?.next_url = nil
      }
      
      
   }
}

extension ListPost: JSONDecodable {
   init?(dictionary: JSONDictionary) {
      guard let posts = dictionary["data"] as? [JSONDictionary],
         let pagination = dictionary["pagination"] as? JSONDictionary else { return nil }
     
      self.data = posts.map { Post(dictionary: $0)! }
      self.pagination = Pagination(dictionary: pagination)!
   }
}
