//
//  User.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation

struct User : Decodable {
   let id: String
   let fullName:String
   let profilePicture:String
   let username:String
   
   enum CodingKeys: String, CodingKey {
      case id
      case fullName  = "full_name"
      case profilePicture = "profile_picture"
      case username
   }
   
   init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      id = try values.decode(String.self, forKey: .id)
      fullName = try values.decode(String.self, forKey: .fullName)
      profilePicture = try values.decode(String.self, forKey: .profilePicture)
      username = try values.decode(String.self, forKey: .username)
   }
}

extension User: JSONDecodable {
   init?(dictionary: JSONDictionary) {
      guard let id = dictionary["id"] as? String,
      let fullName = dictionary["full_name"] as? String,
      let profilePicture = dictionary["profile_picture"] as? String,
      let username = dictionary["username"] as? String
         else { return nil }
      
      self.id = id
      self.fullName = fullName
      self.profilePicture = profilePicture
      self.username = username
   }
}
