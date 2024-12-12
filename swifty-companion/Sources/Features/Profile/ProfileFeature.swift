//
//  ProfileFeature.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/29/24.
//

import ComposableArchitecture

@Reducer
struct ProfileFeature {
  
  @ObservableState
  struct State {
    var login: String? = nil
    var userData: User = User()
    var isLoading = false
    
//    var projectListState = ProjectListFeature.State()
  }
  
  @CasePathable
  enum Action {
    case fetchMyUserData
     case fetchUserData(_ userName: String)
    case fetchResponse(Result<User, NetworkError>)
    
//    case projectListAction(ProjectListFeature.Action)
  }
  
  @Dependency(\.userClient) var userClient
  
  var body: some ReducerOf<Self> {
//    Scope(state: \.projectListState, action: \.projectListAction) {
//      ProjectListFeature()
//    }
    
    Reduce { state, action in
      switch action {
      case .fetchMyUserData:
        state.isLoading = true
        return .none
//        return .run { send in
//          let result = await self.userClient.fetchMyUserData()
//          await send(.fetchResponse(result))
//        }
      case .fetchUserData(let userName):
        state.isLoading = true
        return .run { send in
          let result = await self.userClient.fetchUserDataByName(userName)
          await send(.fetchResponse(result))
        }
        
      case .fetchResponse(.success(let userData)):
        state.isLoading = false
        state.login = userData.login
        state.userData = userData
        debugPrint(state.userData)
        
//        let login = state.login
        return .none
//        return .send(.projectListAction(.fetchProjectListOfUser(login: login!)))
        
      case .fetchResponse(.failure(let error)):
        state.isLoading = false
        print("Error in fetchResponse: \(error)")
        return .none
        
      default: return .none
      }
    }
  }
}
