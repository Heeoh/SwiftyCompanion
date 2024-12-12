//
//  NavigationFeature.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/27/24.
//

import ComposableArchitecture

@Reducer
struct NavigationFeature {
  @ObservableState
  struct State {
    var path = StackState<Path.State>()
  }

  enum Action {
    case goBackToScreen(id: StackElementID)
    case path(StackActionOf<Path>)
    case popToRoot
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case let .goBackToScreen(id):
        state.path.pop(to: id)
        return .none
        
      case let .path(action):
        switch action {
        default:
          return .none
        }
        
      case .popToRoot:
        state.path.removeAll()
        return .none
      }
    }
    .forEach(\.path, action: \.path)
  }
}
