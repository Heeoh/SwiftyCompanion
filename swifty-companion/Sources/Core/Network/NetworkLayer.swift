//
//  NetworkLayer.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/30/24.
//

import Foundation

enum HttpMethod: String {
  case get = "GET"
  case post = "POST"
}

struct ResponseWithHeaders<T> {
  let data: T
  let headers: [String : String]
}

class NetworkLayer {
  let session  = URLSession.shared
  
  func request<R, E>(with endpoint: E) async -> Result<ResponseWithHeaders<R>, NetworkError> where R : Decodable, R == E.Response, E : RequestResponsable {
    do {
      let urlRequest = try endpoint.getUrlRequest()
      
      let (data, response) = try await session.data(for: urlRequest)

      let result = checkError(with: data, response)
      switch result {
      case .success(let (data, headers)):
        do {
          let jsonData = try JSONDecoder().decode(R.self, from: data)
          return .success(ResponseWithHeaders(data: jsonData, headers: headers))
        } catch {
          return .failure(NetworkError.decodingError)
        }
      case .failure(let error):
        return .failure(error)
      }
    } catch(let error) {
      return .failure(NetworkError.urlRequestError(error))
    }
  }
  
  func checkError(with data: Data?, _ response: URLResponse?) -> Result<(Data, [String: String]), NetworkError> {
    // HTTP 응답 검사
    guard let httpResponse = response as? HTTPURLResponse else {
      return .failure(NetworkError.invalidResponse)
    }
    
    // 상태 코드 검사
    guard (200...299).contains(httpResponse.statusCode) else {
      print("ServerError: \(httpResponse.statusCode)")
      return .failure(NetworkError.serverError(ServerError(rawValue: httpResponse.statusCode) ?? .unknown))
    }

    // 데이터 유효성 검사
    guard let data = data else {
      return .failure(NetworkError.emptyData)
    }
    
    let headers = httpResponse.allHeaderFields as? [String: String] ?? [:]

    return .success((data, headers))
  }
}


// https://velog.io/@isouvezz/Swift-Network-Layer-%EA%B5%AC%EC%84%B1%ED%95%98%EA%B8%B0
