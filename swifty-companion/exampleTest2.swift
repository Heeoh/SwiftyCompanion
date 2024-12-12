//
//  exampleTest2.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/27/24.
//

import ComposableArchitecture
import SwiftUI

struct AboutView: View {
  let readMe: String

  var body: some View {
    DisclosureGroup("About this case study") {
      Text(self.readMe)
    }
  }
}

private let readMe = """
  This screen demonstrates how to take small features and compose them into bigger ones using \
  reducer builders and the `Scope` reducer, as well as the `scope` operator on stores.

  It reuses the domain of the counter screen and embeds it, twice, in a larger domain.
  """


@Reducer
struct Counter {
  @ObservableState
  struct State: Equatable {
    var count = 0
  }

  enum Action {
    case decrementButtonTapped
    case incrementButtonTapped
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .decrementButtonTapped:
        state.count -= 1
        return .none
      case .incrementButtonTapped:
        state.count += 1
        return .none
      }
    }
  }
}

struct CounterView: View {
  let store: StoreOf<Counter>

  var body: some View {
    HStack {
      Button {
        store.send(.decrementButtonTapped)
      } label: {
        Image(systemName: "minus")
      }

      Text("\(store.count)")
        .monospacedDigit()

      Button {
        store.send(.incrementButtonTapped)
      } label: {
        Image(systemName: "plus")
      }
    }
  }
}

@Reducer
struct TwoCounters {
  @ObservableState
  struct State: Equatable {
    var counter1 = Counter.State()
    var counter2 = Counter.State()
  }

  enum Action {
    case counter1(Counter.Action)
    case counter2(Counter.Action)
  }

  var body: some Reducer<State, Action> {
    Scope(state: \.counter1, action: \.counter1) {
      Counter()
    }
    Scope(state: \.counter2, action: \.counter2) {
      Counter()
    }
  }
}

struct TwoCountersView: View {
  let store: StoreOf<TwoCounters>

  var body: some View {
    Form {
      Section {
        AboutView(readMe: readMe)
      }

      HStack {
        Text("Counter 1")
        Spacer()
        CounterView(store: store.scope(state: \.counter1, action: \.counter1))
      }

      HStack {
        Text("Counter 2")
        Spacer()
        CounterView(store: store.scope(state: \.counter2, action: \.counter2))
      }
    }
    .buttonStyle(.borderless)
    .navigationTitle("Two counters demo")
  }
}

#Preview {
  NavigationStack {
    TwoCountersView(
      store: Store(initialState: TwoCounters.State()) {
        TwoCounters()
      }
    )
  }
}
