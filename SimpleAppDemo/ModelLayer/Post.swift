//
//  Post.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation


struct Post : Decodable {
   let id: String
   let user: User
   let images: Images
   let likes: Like
   
   enum CodingKeys: String, CodingKey {
      case id
      case user
      case images
      case likes
   }
}

extension Post: JSONDecodable {
   
   init?(dictionary: JSONDictionary) {
      guard let id = dictionary["id"] as? String,
      let user = dictionary["user"] as? JSONDictionary,
      let images = dictionary["images"] as? JSONDictionary,
      let like = dictionary["likes"] as? JSONDictionary else { return nil }
      
      self.id = id
      self.user = User(dictionary: user)!
      self.images = Images(dictionary: images)!
      self.likes = Like(dictionary: like)!
   }
}
