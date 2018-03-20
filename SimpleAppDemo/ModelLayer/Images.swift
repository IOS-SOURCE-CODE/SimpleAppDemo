//
//  Image.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/20/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation

struct Images: Decodable {
   let thumbnail:ImageResource
   let lowResolution: ImageResource
   
   enum CodingKeys: String, CodingKey {
      case thumbnail
      case lowResolution  = "low_resolution"
   }
   
   init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      thumbnail = try values.decode(ImageResource.self, forKey: .thumbnail)
      lowResolution = try values.decode(ImageResource.self, forKey: .lowResolution)
   }
}

extension Images: JSONDecodable {
   init?(dictionary: JSONDictionary) {
      guard let thumbnail = dictionary["thumbnail"] as? JSONDictionary,
      let lowResolution = dictionary["low_resolution"] as? JSONDictionary
         else { return nil }
      
      self.thumbnail = ImageResource(dictionary: thumbnail)!
      self.lowResolution = ImageResource(dictionary: lowResolution)!
   }
}


struct ImageResource: Decodable {
   let width:Int
   let height:Int
   let url:String
   
   enum CodingKeys: String, CodingKey {
      case width
      case height
      case url 
   }
   
   init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      width = try values.decode(Int.self, forKey: .width)
      height = try values.decode(Int.self, forKey: .height)
      url = try values.decode(String.self, forKey: .url)
   }
}

extension ImageResource: JSONDecodable {
   init?(dictionary: JSONDictionary) {
      guard let width = dictionary["width"] as? Int,
      let height = dictionary["height"] as? Int,
         let url = dictionary["url"] as? String else { return nil }
      
      self.width = width
      self.height = height
      self.url = url
   }
}
