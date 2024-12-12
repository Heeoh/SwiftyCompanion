//
//  CustomNavigationBar.swift
//  swifty-companion
//
//  Created by Heeoh Son on 9/2/24.
//

import SwiftUI

struct DefaultRightButton: View {
  var body: some View {
    Rectangle()
  }
}

struct CustomNavigationBar<Content: View>: View {
  @Environment(\.dismiss) var dismiss
  @Environment(\.presentationMode) var presentationMode
  
  let title: String
  let rightButton: () -> Content
  let buttonSize: CGFloat = 24
  
  // Initializer when right button is present
  init(title: String = "", @ViewBuilder rightButton: @escaping () -> Content) {
    self.title = title
    self.rightButton = rightButton
  }
      
  // Initializer when there is no right button
  init(title: String = "") where Content == DefaultRightButton {
    self.title = title
    self.rightButton = { DefaultRightButton() }
  }
  
  var body: some View {
    let isRootPage = !self.presentationMode.wrappedValue.isPresented
    
    HStack {
      SystemIconButton("chevron.left", color: isRootPage ? Color.clear : Color.white) {
        print("back")
        self.dismiss()
      }.frame(width: buttonSize)
      
      Spacer()
      
      Text(title)
        .foregroundColor(.white)
      
      Spacer()
      
      rightButton()
        .frame(width: buttonSize)
    }
    .frame(height: 56)
    .padding(.horizontal, Layout.side)
    .padding(.top, 50)
    
  }
}

struct CustomNavigationDemoView: View {
  var body: some View {
    VStack {
      CustomNavigationBar(title: "title", rightButton: {
        SystemIconButton("rectangle.portrait.and.arrow.right", color: Color.white) {
          print("logout")
        }
      })
      CustomNavigationBar(title: "title")
      Spacer()
    }
    .background(Color.black)
    .ignoresSafeArea()
  }
}

#Preview {
  CustomNavigationDemoView()
}
