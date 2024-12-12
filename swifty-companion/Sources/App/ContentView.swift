//
//  ContentView.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/19/24.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
  
  var body: some View {
    HomeView(
      store: Store(initialState: SearchCore.State()) {
        SearchCore()
      }
    )
  }
}

#Preview {
    ContentView()
}

//
//struct TileView: View {
//  let title: String
//  let subtitle: String
//  
//  var body: some View {
//    ZStack {
//      RoundedRectangle(cornerRadius: 8)
//        .frame(maxWidth: .infinity)
//        .frame(height: 119)
//        .foregroundColor(Color(hex: "D60665"))
//        .overlay (
//          VStack {
//            Spacer()
//            Text(title)
//              .frame(maxWidth: .infinity, alignment: .leading)
//              .font(.headline)
//            Text(subtitle)
//              .frame(maxWidth: .infinity, alignment: .leading)
//          }
//          .foregroundColor(.black)
//          .padding()
//        )
//    }
//  }
//}
//
//struct ContentView: View {
//  
//  var body: some View {
//    VStack {
//      VStack(alignment: .leading, spacing: 20) {
//        Text("Good Evening, Mehroz")
//        Text("What’s for dinner?There are 567 restaurants in your area")
//          .frame(maxWidth: .infinity)
//      }
//      
//      // search bar
//      
//      // food delivery
//      RoundedRectangle(cornerRadius: 8)
//        .frame(maxWidth: .infinity)
//        .frame(height: 135)
//        .foregroundColor(Color(hex: "D60665"))
//      
//      HStack(spacing: 20) {
//        // pandamart
//        RoundedRectangle(cornerRadius: 8)
//          .frame(maxWidth: .infinity)
//          .frame(height: 199)
//          .foregroundColor(Color(hex: "D60665"))
//        
//        VStack(spacing: 20) {
//          // pick up button
//          Button(action: {
//            print("click")
//          }, label: {
//            TileView(title: "Pick-Up", subtitle: "Everydat up to 25% off")
//          })
//          
////          RoundedRectangle(cornerRadius: 8)
////            .frame(maxWidth: .infinity)
////            .frame(height: 119)
////            .foregroundColor(Color(hex: "D60665"))
//          
//          // shops
//          RoundedRectangle(cornerRadius: 8)
//            .frame(maxWidth: .infinity)
//            .frame(height: 60)
//            .foregroundColor(Color(hex: "D60665"))
//        }
//      }
//      
//      Text("Your Restaurants")
//        .frame(maxWidth: .infinity, alignment: .leading)
//      
//      HStack(spacing: 20) {
//        Image("image1")
////          .resizable()
////          .scaledToFit()
////          .frame(wdith: 100, height: 100)
//        
//        
//        RoundedRectangle(cornerRadius: 8)
//          .frame(width: 104, height: 100)
//          .foregroundColor(Color(hex: "D60665"))
//      }
//    }.padding(.horizontal, 24)
//  }
//}

//#Preview {
//    ContentView()
//}
