//
//  Error.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/29/24.
//

import Foundation

//enum APIError: Error {
//  case invalidRequest
//  case invalidResponse
//  case networkError(Error)
//}

enum NetworkError: Error {
  case unknownError
  case urlComponentsError
  case urlRequestError(Error)
  case invalidResponse
  case serverError(ServerError)
  case emptyData
  case decodingError
}

enum ServerError: Int {
  case unknown
  case badRequest = 400
  case unauthorized = 401
  case forbidden = 403
  case notFound = 404
  case nnprocessableEntity = 422
  case serverError = 500
}
