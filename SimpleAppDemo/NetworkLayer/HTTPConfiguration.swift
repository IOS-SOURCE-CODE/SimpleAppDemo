//
//  HTTPConfiguration.swift
//  SimpleAppDemo
//
//  Created by Hiem Seyha on 3/19/18.
//  Copyright © 2018 seyha. All rights reserved.
//

import Foundation

enum Method: String {
   case GET , POST
}

enum HTTPHeaderField: String {
   case authentication = "Authorization"
   case contentType = "Content-Type"
   case acceptType = "Accept"
   case acceptEncoding = "Accept-Encoding"
   case accessToken = "access_token"
}

enum ContentType: String {
   case json = "application/json"
}

//TODO: Should store in keychain
struct Authentication {
   static let apiKey = "7322641520.f494368.f1ba46d284894a73bc75e04be1344c81"
}
