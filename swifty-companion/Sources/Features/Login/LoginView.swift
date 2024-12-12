//
//  LoginView.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/19/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct LoginView: View {
  @Bindable var authStore: StoreOf<AuthFeature>
  
  var body: some View {
    ZStack {
      Image("sky")
        .resizable()
        .clipped()
        .ignoresSafeArea()
      
      VStack(spacing: 0) {
        
        Spacer()
        
        Image("char").resizable().scaledToFit()
          .frame(width: 200)
          .padding(.bottom, 20)
        
        Group {
          Text("Swifty")
            .foregroundColor(.white)
          Text("Comapnion")
            .foregroundColor(Color(hex: "FFE500"))
        }.font(.system(size: 36)).bold()
        
        Text("for 42 SEOUL")
          .foregroundColor(Color.white)
          .font(.title3).bold()
          .padding()
        
        Spacer()
        
        Button {
          // print("do login")
          authStore.send(.loginButtonTapped)
        } label: {
          Group {
            if authStore.isAuthenticating {
              ProgressView()
            } else {
              Text("Let's START!")
                .bold()
            }
          }.padding(10)
        }
        .buttonStyle(CustomButtonStyle())
        .padding(.bottom, 60)
        .padding(.horizontal, Layout.side)
        
      }
      .alert($authStore.scope(state: \.errorAlert, action: \.alert))
    }.frame(maxWidth: .infinity)
  }
}

#Preview {
  LoginView(authStore: Store(initialState: AuthFeature.State()) {
    AuthFeature()
  })
}

//        ZStack {
//          RoundedRectangle(cornerRadius: Radius.large)
//            .foregroundColor(.yellow)
//            .frame(width: 300, height: 60)
//          RoundedRectangle(cornerRadius: Radius.large)
//            .foregroundColor(.white)
//            .padding(5)
//            .frame(width: 300, height: 60)
//          Text("Swifty Companion")
//            .foregroundColor(.black)
//            .font(.title3)
//            .bold()
//        }

//        Spacer()


//        HStack(spacing: 20) {
//          RoundedRectangle(cornerRadius: Radius.large)
//            .foregroundColor(.white)
//            .frame(width: 55, height: 55)
//            .overlay {
//              Text("42")
//                .font(.title3).bold()
//            }
//
//          RoundedRectangle(cornerRadius: Radius.large)
//            .foregroundColor(.white)
//            .frame(width: 55, height: 55)
//            .overlay {
//              Image(systemName: "apple.logo")
//            }
//
//          RoundedRectangle(cornerRadius: Radius.large)
//            .foregroundColor(.white)
//            .frame(width: 55, height: 55)
//            .overlay {
//              Text("guest")
//                .font(.headline)
//            }
//        }.padding(.bottom, 60)
