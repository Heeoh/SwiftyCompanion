//
//  SlidingToggleCore.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/19/24.
//

import ComposableArchitecture

@Reducer
struct SlidingToggleCore {
  
  @ObservableState
  struct State {
    let items: [String]
    let itemCount: Int
    var tappedItem: String
    //    var tappedItemName
    
    init(items: [String]) {
      self.items = items
      self.itemCount = items.count
      self.tappedItem = self.itemCount > 0 ? items[0] : ""
    }
  }
  
  enum Action {
    case tapItem(String)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .tapItem(let item):
        state.tappedItem = item
        return .none
      }
    }
  }
}


