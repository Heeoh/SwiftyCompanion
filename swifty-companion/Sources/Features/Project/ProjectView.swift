//
//  ProjectView.swift
//  swifty-companion
//
//  Created by Heeoh Son on 9/26/24.
//

import SwiftUI

extension View {
  func leadingAlignedText() -> some View {
    self
      .frame(maxWidth: .infinity, alignment: .leading)
//      .padding() // 필요에 따라 추가 padding
  }
}

struct ProjectView: View {
  let name: String
  let description = "This project is an introduction to mobile programming. The goal is to create, an application which will allow you to get infos about 42students, using the API."
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    VStack(spacing: 0) {
      CustomNavigationBar()
      
//      ScrollView {
        VStack(spacing: 0) {
          Text("circle info")
            .leadingAlignedText()
            .font(.system(size: 14))
//            .background(Color.yellow)
          
          Text(name)
            .leadingAlignedText()
            .font(.system(size: 32))
            .bold()
            .padding(.vertical)
//            .background(Color.red)
          
          
        }.padding(.horizontal, Layout.side)
      
          
//      }
      .foregroundColor(.white)
      Spacer()
      
    }.sheet(isPresented: .constant(true)) {
      VStack {
        Text(description)
          .leadingAlignedText()
          .padding(.vertical)
        
        HStack {
          Text("Mobile")
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.yellow)
            .cornerRadius(24)
          
          Text("API-42")
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.yellow)
            .cornerRadius(24)
          
          Text("DB & Data")
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.pink)
            .cornerRadius(24)
          
        }
        
        HStack(alignment: .center, spacing: 15) {
          dataTileView(title: "grade", value: "1 인")
          verticalDivider(width: 1, height: 30, color: .white.opacity(0.6))
          dataTileView(title: "level", value: "49 Hours")
          verticalDivider(width: 1, height: 30, color: .white.opacity(0.6))
          dataTileView(title: "uptime", value: "4200 XP")
        }
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .cornerRadius(16)
        .padding(.horizontal, Layout.side)
        .padding(.top, 12)
        .padding(.bottom, 20)
        
        
        
        Spacer()
      }
      .padding(.vertical, 25)
      .padding(.horizontal, Layout.side)
        .presentationDetents([.fraction(0.83)])
        .interactiveDismissDisabled()
        .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.83)))
    }
    
    .background(Image("sky").resizable().clipped())
    .ignoresSafeArea()
  }
  
  func dataTileView(title: String = "", value: String = "") -> some View {
    VStack(alignment: .center, spacing: 4) {
      Text(title)
        .font(.subheadline)
        .foregroundColor(.white.opacity(0.7))
      Text(value)
        .font(.headline)
        .foregroundColor(.white)
    }
    
    .frame(width: 84 ,height: 40)
  }
  
  func verticalDivider(width: CGFloat, height: CGFloat, color: Color) -> some View {
    Rectangle()
      .foregroundColor(color)
      .frame(width: width, height: height)
  }
}

#Preview {
  ProjectView(name: "hello")
}
