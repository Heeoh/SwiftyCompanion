//
//  Requestable.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/30/24.
//

import Foundation

protocol Requestable {
  var baseURL: String { get }
  var path: String { get }
  var method: HttpMethod { get }
  var headers: [String: String] { get }
  var queryParameters: [String: String] { get }
  var bodyParameters: [String : Any] { get }
//  var sampleData: Data? { get }
}

extension Requestable {
  func getUrlRequest() throws -> URLRequest {
    let url = try makeUrl()
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    
    headers.forEach { key,value in
      urlRequest.setValue(value, forHTTPHeaderField: "\(key)")
    }
    
    if !bodyParameters.isEmpty {
      urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters)
    }
    
    return urlRequest
  }
  
  func makeUrl() throws -> URL {
    let fullPath = "\(baseURL)\(path)"
    guard var urlComponents = URLComponents(string: fullPath) else {
      throw NetworkError.urlComponentsError
    }
    
    var urlQueryItems = [URLQueryItem]()
    queryParameters.forEach { key,value in
      urlQueryItems.append(URLQueryItem(name: key, value: "\(value)"))
    }
    
    urlComponents.queryItems = urlQueryItems.isEmpty ? nil : urlQueryItems
    guard let url = urlComponents.url else { throw NetworkError.urlComponentsError }
    
    return url
  }
}
