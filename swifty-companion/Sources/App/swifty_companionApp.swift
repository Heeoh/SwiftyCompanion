//
//  swifty_companionApp.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/19/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct swifty_companionApp: App {
  @Bindable var authStore = Store(initialState: AuthFeature.State()) {
    AuthFeature()
  }
  
  var body: some Scene {
    WindowGroup {
      if authStore.isAuthenticated {
        ContentView()
      } else {
        LoginView(authStore: authStore)
          .onOpenURL { url in
            handleIncomingURL(url)
          }
      }
    }
  }
  
  private func handleIncomingURL(_ url: URL) {
    guard url.scheme == "swiftycompanionapp",
          url.host == "oauth",
          url.path == "/callback" else {
      print("Error in handleIncomingURL: unknown url")
      return
    }
    
    guard let code = URLComponents(url: url, resolvingAgainstBaseURL: false)?
      .queryItems?.first(where: { $0.name == "code" })?.value else {
      print("Error in handleIncomingURL: no code")
      return
    }
    
    // 받은 code를 처리
    // print("Received OAuth code: \(code)")
    authStore.send(.handleOAuthCode(code))

  }
  
}
