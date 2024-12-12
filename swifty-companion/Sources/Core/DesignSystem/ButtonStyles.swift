//
//  ButtonStyles.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/19/24.
//

import SwiftUI

enum ButtonStyleType {
  case solid
  case ghost
}

enum ButtonActiveSate {
  case active
  case inactive
}

struct CustomButtonStyle: ButtonStyle {
  var cornerRadius: CGFloat = Radius.medium
  var state: ButtonActiveSate = .active
  var style: ButtonStyleType = .solid
  
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .padding(6)
      .frame(maxWidth: .infinity)
      .foregroundColor(.hio.label.normal)
      .background(Color(hex: "FFE500"))
      .cornerRadius(cornerRadius)
    
//    switch state {
//    case .active:
//        switch style {
//        case .solid:
//            activeSolid(configuration: configuration)
//        case .ghost:
//            activeGhost(configuration: configuration)
//        }
//    case .inactive:
//      switch style {
//      case .solid:
//        inactiveSolid(configuration: configuration)
//      default:
//        inactive(configuration: configuration)
//      }
//    }
  }
    
//  private func activeSolid(configuration: Self.Configuration) -> some View {
//    configuration.label
//      .foregroundColor(.hio.label.r_normal)
//      .background(Color.hio.brand.primary)
//      .cornerRadius(cornerRadius)
//  }
//  
//  private func activeGhost(configuration: Self.Configuration) -> some View {
//    configuration.label
//      .foregroundColor(.hio.brand.primary)
//      .overlay(
//        RoundedRectangle(cornerRadius: cornerRadius)
//          .stroke(Color.hio.brand.primary, lineWidth: 1)
//      )
//  }
//  
//  private func inactive(configuration: Self.Configuration) -> some View {
//    configuration.label
//      .foregroundColor(.hio.label.inactive)
//      .background(Color.hio.system.inactive)
//      .cornerRadius(cornerRadius)
//  }
//
//  private func activeBasic(configuration: Self.Configuration) -> some View {
//      configuration.label
//          .foregroundColor(.hio.label.assistive)
//          .background(Color.hio.elevation.elev2)
//          .cornerRadius(cornerRadius)
//  }
//
//  private func inactiveSolid(configuration: Self.Configuration) -> some View {
//    configuration.label
//        .foregroundColor(.hio.label.inactive)
//        .background(Color.hio.elevation.elev2)
//        .cornerRadius(cornerRadius)
//  }
    
}
