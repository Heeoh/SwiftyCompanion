//
//  IconButton.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/21/24.
//

import SwiftUI

extension View {
  
  func IconButton(_ iconImage: String,
                  color: Color = Color.black,
                  action: @escaping () -> Void) -> some View {
    Button(action: action) {
      Image(iconImage)
        .padding(6)
        .foregroundColor(color)
    }
  }
      
  func SystemIconButton(_ systemImage: String,
                        color: Color = Color.black,
                        size: CGFloat = 22,
                        action: @escaping () -> Void) -> some View {
    Button(action: action) {
      Image(systemName: systemImage)
        .font(.system(size: size))
        .padding(6)
        .foregroundColor(color)
    }
  }
}
