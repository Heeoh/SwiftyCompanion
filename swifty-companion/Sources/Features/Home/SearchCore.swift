//
//  SearchCore.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/21/24.
//

import ComposableArchitecture
  
@Reducer 
struct SearchCore {
  
  @ObservableState
  struct State: Equatable {
    var query: String = ""
    var userResult: SimpleUsers = []
    var projectResult: Projects = []
    var isShowingResults: Bool = false
    
    var isUsersLoading: Bool = false
    var isProjectsLoading: Bool = false
//    var page = 0
//    var hasMoreResult: Bool = true
  }

  enum Action {
//    case binding(BindingAction<State>)
    case queryChanged(String)
    case showResults
    case searchUsers(String)
    case searchUsersResponse(Result<SimpleUsers, NetworkError>)
    case searchProjects(String)
    case searchProjectsResponse(Result<Projects, NetworkError>)
    case fetchSearchResults
  }

  @Dependency(\.userClient) var userClient
  @Dependency(\.projectClient) var projectClient

  var body: some ReducerOf<Self> {
//    BindingReducer()
    Reduce { state, action in
      switch action {
//      case .binding(\.query):
//        //        print("query", state.query)
//        return .none
//      case .binding(_):
//        return .none
      case .queryChanged(let query):
        guard state.query != query else {
          return .none
        }
        state.query = query
        print(state.query)
        if isQueryAvailable(state.query) {
          return .merge (
            .run { send in
                await send(.searchUsers(query))
            },
            .run { send in
                await send(.searchProjects(query))
            }
        )} else {
          return .none
        }
      case .showResults:
        if state.isShowingResults == false && isQueryAvailable(state.query) {
          state.isShowingResults.toggle()
        } else if state.isShowingResults == true && !isQueryAvailable(state.query) {
          state.isShowingResults.toggle()
          state.userResult = []
          state.projectResult = []
        }
        return .none
        
      case .searchUsers(let login) :
        state.isUsersLoading = true
        return .run { send in
          let result = await userClient.searchUsersByName(login)
          await send(.searchUsersResponse(result))
        }
      case .searchUsersResponse(.success(let result)):
        state.isUsersLoading = false
        state.userResult = result
//        print("search user response: \(result)")
        return .none
      case .searchUsersResponse(.failure(let error)):
        state.isUsersLoading = false
        print("Error in searchUsersResponse: \(error)")
        return .none
        
      case .searchProjects(let name) :
        state.isProjectsLoading = true
        return .run { send in
          let result = await projectClient.searchProjectsByName(name)
          await send(.searchProjectsResponse(result))
        }
      case .searchProjectsResponse(.success(let result)):
        state.isProjectsLoading = false
        state.projectResult = result
        print("search project response: \(result)")
        return .none
      case .searchProjectsResponse(.failure(let error)):
        state.isProjectsLoading = false
        print("Error in searchProjectsResponse: \(error)")
        return .none
      default:
        return .none
      }
    }
  }
  
  private func isQueryAvailable(_ query: String) -> Bool {
    return (query.count > 1)
  }
}

