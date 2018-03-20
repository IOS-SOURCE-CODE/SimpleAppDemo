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
   let width:String
   let height:String
   let url:String
}

extension ImageResource: JSONDecodable {
   init?(dictionary: JSONDictionary) {
      guard let width = dictionary["width"] as? String,
      let height = dictionary["height"] as? String,
         let url = dictionary["url"] as? String else { return nil }
      
      self.width = width
      self.height = height
      self.url = url
   }
}
