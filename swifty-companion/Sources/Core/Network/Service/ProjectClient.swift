//
//  ProjectClient.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/29/24.
//

import ComposableArchitecture

struct ProjectClient {
  var fetchProjectListOfUser: @Sendable (String) async -> Result<ProjectUsers, NetworkError>
  var searchProjectsByName: @Sendable (String) async -> Result<Projects, NetworkError>
//  var fetchProjectList: @Sendable (Int) async -> Result<[Project], NetworkError>
}

extension ProjectClient: DependencyKey {
  static var liveValue = ProjectClient (
    fetchProjectListOfUser: { login in
      var endpoint = APIEndpoints.fetchProjectListOfUser(login: login)
      let result = await NetworkLayer().request(with: endpoint)
      switch result {
      case .success(let response):
        return .success(response.data)
      case .failure(let error):
        return .failure(error)
      }
    }, searchProjectsByName: { name in
      let endpoint = APIEndpoints.searchProject(name)
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
  var projectClient: ProjectClient {
    get { self[ProjectClient.self] }
    set { self[ProjectClient.self] = newValue }
  }
}

