//
//  SlidingToggleView.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/19/24.
//

import SwiftUI
import ComposableArchitecture

struct SlidingToggleView: View {

  let store: StoreOf<SlidingToggleCore>
  
  var body: some View {
    GeometryReader { g in
      let itemCount = store.itemCount
      let itemButtonWidth: CGFloat = g.size.width / CGFloat(itemCount)
      
      HStack(spacing: 0) {
        ForEach(store.items, id: \.self) { anItem in
          Button {
            if store.tappedItem != anItem {
              store.send(.tapItem(anItem))
            }
          } label: {
            Text(anItem)
              .padding(.vertical)
              .frame(width: itemButtonWidth)
              .foregroundColor(Color(hex: "#777777"))
              .overlay(
                Rectangle()
                  .frame(height: 4)
                  .foregroundColor(store.tappedItem ==  anItem ? Color(hex: "003566") : .clear),
                alignment: .bottom
              )
          }
        }
      }
    }
  }
}

#Preview {
  SlidingToggleView(
    store: Store(initialState: SlidingToggleCore.State(items: ["Projects", "Skills", "Projects"])) {
      SlidingToggleCore()
    }
  )
}

/*
var body: some View {
  GeometryReader { geometry in
    let itemContainerWidth: CGFloat = geometry.size.width / itemCount - (Layout.side)
    let xOffset: CGFloat = store.tappedItem == 1 ? 0 : itemContainerWidth
    
    
    ZStack(alignment: .leading) {
      RoundedRectangle(cornerRadius: Radius.small)
        .frame(width: itemContainerWidth, height: 44)
        .foregroundColor(.white)
        .padding(.horizontal, Layout.side)
        .shadow(color: Color.gray.opacity(0.25), radius: 4, y: 4)
        .offset(x: xOffset)
        .animation(.easeInOut, value: xOffset)
        
      
      HStack(alignment: .center, spacing: 10) {
        Spacer()
        Button {
          if store.tappedItem != 1 {
            store.send(.tapItem1)
          }
        } label: {
          toggleLabelView(label: "Projects")
            .frame(width: 120)
            .foregroundColor(store.tappedItem == 1 ? .yellow : .gray)
        }
        
        Spacer()
        
        Button {
          if store.tappedItem != 2 {
            store.send(.tapItem2)
          }
        } label: {
          toggleLabelView(label: "Skills")
            .frame(width: 120)
            .foregroundColor(store.tappedItem == 2 ? .yellow : .gray)
        }
        Spacer()
      }
      .frame(maxWidth: .infinity)
      
    }
    .frame(maxWidth: .infinity)
    .frame(height: 64)
    .background(Color.gray.opacity(0.1))
    .cornerRadius(Radius.medium)
  }.frame(height: 64)
}
*/
