//
//  Auth.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/28/24.
//

import Foundation

struct Auth: Codable {
  var accessToken: String
  
  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
  }
}
