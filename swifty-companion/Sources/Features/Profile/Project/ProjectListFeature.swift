//
//  ProjectListCore.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/20/24.
//

import ComposableArchitecture

@Reducer
struct ProjectListFeature {
  
  @ObservableState
  struct State {
    var isLoading = false
    var inProgressProjectList: ProjectUsers = []
    var completedProjectList: ProjectUsers = []
  }
  
  enum Action {
    case fetchProjectListOfUser(login: String)
    case fetchResponse(Result<ProjectUsers, NetworkError>)
  }
  
  @Dependency(\.projectClient) var client
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .fetchProjectListOfUser(let login):
        state.isLoading = true
        return .run { send in
//          print("fetch start")
          let result = await client.fetchProjectListOfUser(login)
          await send(.fetchResponse(result))
        }
        
      case .fetchResponse(.success(let projectList)):
//        print(projectList)
        
        state.inProgressProjectList = projectList.filter {
          $0.status == .inProgress
        }
        state.completedProjectList = projectList.filter {
          $0.marked == true
        }
        state.isLoading = false
        return .none
        
      case .fetchResponse(.failure(let error)):
        debugPrint("Error in fetchResponse of ProjectClient: \(error)")
        state.isLoading = false
        return .none
      }
    }
  }
}


