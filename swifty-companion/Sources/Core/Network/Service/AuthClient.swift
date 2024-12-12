//
//  AuthClient.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/28/24.
//

import ComposableArchitecture
import UIKit

let myBaseURL = "https://api.intra.42.fr"
let clientID = "u-s4t2ud-d3387d116cd9f4b6f044edf2f53a0649e183bdd98c00086d74a9a750d0ba3b8b"
let clientSecret = "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"
let redirectURI = "swiftyCompanionApp://oauth/callback"


struct AuthClient {
  var authorizeUser: @Sendable () async throws -> Void
  var getAccessToken: @Sendable (String) async -> Result<String, NetworkError>
  var fetchMyUserData: @Sendable () async -> Result<SimpleUser, NetworkError>
}

extension AuthClient: DependencyKey {
  static let liveValue = AuthClient (
    authorizeUser: {
      // print("authorize user")
      guard let url = URL(string: "\(myBaseURL)/oauth/authorize?client_id=\(clientID)&redirect_uri=\(redirectURI)&response_type=code") else {
        throw NetworkError.urlComponentsError
      }
      
      // URL을 브라우저에서 열기
      DispatchQueue.main.async {
        UIApplication.shared.open(url)
      }
      
    }, getAccessToken: { code in
      // print("get access token with code \(code)")
      let endpoint = APIEndpoints.getAccessToken(code: code)
      let result = await NetworkLayer().request(with: endpoint)
      switch result {
      case .success(let response):
        return .success(response.data.accessToken)
      case .failure(let error):
        return .failure(error)
      }
      
    }, fetchMyUserData: {
      let endpoint = APIEndpoints.fetchMyUserData()
      let result = await NetworkLayer().request(with: endpoint)
      switch result {
      case .success(let response):
        let data = SimpleUser(id: response.data.id, login: response.data.login, image: response.data.image)
        return .success(data)
      case .failure(let error):
        return .failure(.invalidResponse)
      }
    }
  )
}

extension DependencyValues {
  var authClient: AuthClient {
    get { self[AuthClient.self] }
    set { self[AuthClient.self] = newValue }
  }
}
