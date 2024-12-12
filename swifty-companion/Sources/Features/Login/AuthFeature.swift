//
//  AuthFeature.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/27/24.
//

import ComposableArchitecture
import Foundation
import SwiftUI

@Reducer
struct AuthFeature {
  
  @ObservableState
  struct State {
    static var accessToken: String = ""
    static var userData: SimpleUser = SimpleUser()
    var isAuthenticated = false
    var isAuthenticating = false
    
    // error alert
    @Presents var errorAlert: AlertState<Action.Alert>?
  }
  
  enum Action {
    case loginButtonTapped
    case handleOAuthCode(String)
    case accessTokenResponse(Result<String, NetworkError>)
    case getMyData
    case myDataResponse(Result<SimpleUser, NetworkError>)
    case handleAuthError(NetworkError)
    
    // error alert
    case alert(PresentationAction<Alert>)
    
    @CasePathable
    enum Alert {}
  }
  
  @Dependency(\.authClient) var authClient
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .loginButtonTapped:
        state.isAuthenticating = true
        return .run { send in
          try await self.authClient.authorizeUser()
        }
        
      case .handleOAuthCode(let code):
         print("handle OAuth code")
        return .run { send in
          let result = await self.authClient.getAccessToken(code)
          await send(.accessTokenResponse(result))
        }
        
      case .accessTokenResponse(.success(let token)):
        AuthFeature.State.accessToken = token
        return .send(.getMyData)
        
      case .accessTokenResponse(.failure(let error)):
        return .send(.handleAuthError(error))
        
      case .getMyData:
        return .run { send in
          let result = await self.authClient.fetchMyUserData()
          await send(.myDataResponse(result))
        }
        
      case .myDataResponse(.success(let data)):
        AuthFeature.State.userData = data
        state.isAuthenticating = false
        state.isAuthenticated = true
        return .none
        
      case .myDataResponse(.failure(let error)):
        return .send(.handleAuthError(error))
        
      case .handleAuthError(let error):
        state.isAuthenticating = false
        state.isAuthenticated = false
        state.errorAlert = AlertState {
          TextState("Error")
        } actions: {
          ButtonState(role: .cancel) {
            TextState("OK")
          }
        } message: {
          TextState("로그인을 실패하였습니다.")
        }
        debugPrint("Error in handleAuthError: \(error)")
        return .none
  
      default: return .none
      }
    }
    .ifLet(\.$errorAlert, action: \.alert)
  }
}

// MEMO: dependency error handling
//https://green1229.tistory.com/448

// MEMO: TCA
// https://medium.com/@youable.framios/whats-your-eta-what-s-your-tca-mmm-hmm-swiftui-tca%EB%A5%BC-%EC%8B%9C%EC%9E%91%ED%95%98%EA%B8%B0-%EC%A0%84%EC%97%90-%EB%B3%B4%EB%A9%B4-%EC%A2%8B%EC%9D%80-%EA%B8%80-6cfeb92dbc29
