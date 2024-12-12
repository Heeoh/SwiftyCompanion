//
//  Endpoint.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/30/24.
//

import Foundation

let cursusId = 21
let campusId = 29

class EndPoint<R>: RequestResponsable {
  typealias Response = R
  var baseURL: String = myBaseURL
  var path: String
  var method: HttpMethod
  var headers: [String: String]
  var queryParameters: [String: String]
  var bodyParameters: [String : Any]
  //  var sampleData: Data?
  
  init(path: String,
       method: HttpMethod = .get,
       headers:[String:String] = [:],
       queryParameters: [String: String] = [:],
       bodyParameters: [String : Any] = [:]) {
    self.path = path
    self.method = method
    self.queryParameters = queryParameters
    self.bodyParameters = bodyParameters
    self.headers = headers
  }
}

struct APIEndpoints {}

// MARK: Auth
extension APIEndpoints {
  static func getAccessToken(code: String) -> EndPoint<Auth> {
    let queryParameters: [String:String] = [
      "grant_type": "authorization_code",
      "client_id": clientID,
      "client_secret": clientSecret,
      "code": code,
      "redirect_uri": redirectURI
    ]
    
    return EndPoint(path: "/oauth/token",
                    method: .post,
                    headers: ["Content-Type": "application/x-www-form-urlencoded"],
                    queryParameters: queryParameters
                    
    )
  }
  
  static func fetchMyUserData() -> EndPoint<User> {
    return EndPoint(path: "/v2/me",
                    headers: ["Authorization" : "Bearer \(AuthFeature.State.accessToken)"])
  }
}

// MARK: User
extension APIEndpoints {
  static func fetchUserDataByName(_ login: String) -> EndPoint<User> {
    return EndPoint(path: "/v2/users/\(login)",
                    headers: ["Authorization" : "Bearer \(AuthFeature.State.accessToken)"])
  }
  
  static func fetchUserList(_ page: Int, _ size: Int) -> EndPoint<SimpleUsers> {
    let queryParameters: [String:String] = [
      "page": "\(page)",
      "per_page": "\(size)"
    ]
    
    return EndPoint(path: "/v2/campus/\(campusId)/users?page=\(page)&per_page=\(size)",
                    headers: ["Authorization" : "Bearer \(AuthFeature.State.accessToken)"],
                    queryParameters: queryParameters)
  }
  
  static func searchUser(_ login: String) -> EndPoint<SimpleUsers> {
    let queryComponents = login.lowercased() + "," + login.lowercased() + "z"
    let queryParameters: [String:String] = [
      "range[login]": queryComponents,
      "per_page": "5"
    ]
    
    return EndPoint(path: "/v2/campus/\(campusId)/users",
                    headers: ["Authorization" : "Bearer \(AuthFeature.State.accessToken)"],
                    queryParameters: queryParameters)
  }
}

// MARK: Project
extension APIEndpoints {
  static func fetchProjectListOfUser(login: String) -> EndPoint<ProjectUsers> {
    return EndPoint(path: "/v2/users/\(login)/projects_users",
                    headers: ["Authorization" : "Bearer \(AuthFeature.State.accessToken)"])
    
  }
  
  static func searchProject(_ name: String) -> EndPoint<Projects> {
    let queryComponents = name.lowercased() + "," + name.lowercased() + "z"
    let queryParameters: [String:String] = [
      "range[name]": queryComponents,
      "per_page": "5"
    ]
    
    return EndPoint(path: "/v2/cursus/\(cursusId)/projects",
                    headers: ["Authorization" : "Bearer \(AuthFeature.State.accessToken)"],
                    queryParameters: queryParameters)
  }

}
