//
//  UserClient.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/21/24.
//

import ComposableArchitecture
import SwiftUI

struct UserClient {
  var fetchUserDataByName: @Sendable (_ login: String) async -> Result<User, NetworkError>
//  var fetchUserList: @Sendable (_ page: Int, _ size: Int) async -> Result<ResponseWithHeaders<SimpleUsers>, NetworkError>
  var searchUsersByName: @Sendable (_ login: String) async -> Result<SimpleUsers, NetworkError>
}

extension UserClient: DependencyKey {
  static var liveValue = UserClient(
    fetchUserDataByName: { login in
      let endpoint = APIEndpoints.fetchUserDataByName(login)
      let result = await NetworkLayer().request(with: endpoint)
      switch result {
      case .success(let response):
        return .success(response.data)
      case .failure(let error):
        return .failure(.invalidResponse)
      }
//    }, fetchUserList: { page, size in
//      let endpoint = APIEndpoints.fetchUserList(page, size)
//      let result = await NetworkLayer().request(with: endpoint)
//      switch result {
//      case .success(let response):
//        return .success(response)
//      case .failure(let error):
//        return .failure(.invalidResponse)
//      }
    }, searchUsersByName: { login in
      let endpoint = APIEndpoints.searchUser(login)
      let result = await NetworkLayer().request(with: endpoint)
      switch result {
      case .success(let response):
        return .success(response.data)
      case .failure(let error):
        return .failure(.invalidResponse)
      }
    }
  )
}
  

extension DependencyValues {
  var userClient: UserClient {
    get { self[UserClient.self] }
    set { self[UserClient.self] = newValue }
  }
}
