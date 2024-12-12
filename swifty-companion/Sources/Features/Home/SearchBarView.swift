//
//  SearchBar.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/21/24.
//

import SwiftUI
import ComposableArchitecture

struct SearchBarView: View {
//  @Binding var query: String
//  @State private var searchInput: String = ""
  @Bindable var store: StoreOf<SearchCore>
  
  var body: some View {
    HStack {
      SystemIconButton("magnifyingglass") {}
      
      TextField(
        "Search.. ",
        text: $store.query.sending(\.queryChanged)
      )
//      .disableAutocorrection(true)
      
    }
    .padding()
    .frame(maxWidth: .infinity)
    .frame(height: 50)
    .background(Color.white)
    .cornerRadius(Radius.medium)
    .shadow(
      color: Color(red: 0, green: 0, blue: 0, opacity: 0.2),
      radius: 10,
      y: 8
    )
    
  }
}

//#Preview {
//  SearchBarView(query: .constant(""))
//}


