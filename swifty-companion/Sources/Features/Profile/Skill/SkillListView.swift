//
//  SkillListView.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/20/24.
//

import SwiftUI

struct SkillListView: View {
  var body: some View {
    
    Section(header: sectionHeaderView(headerStr: "내가 보유한 스킬")) {
      VStack {
        ForEach(0...5, id: \.self) { id in
          HStack {
            Text("Skill \(id)")
            Spacer()
            Text("진행중")
          }
        }
      }
      .padding()
      .background(Color.yellow)
      .cornerRadius(Radius.medium)
    }
  }
}

extension SkillListView {
  func sectionHeaderView(headerStr: String) -> some View {
    Text(headerStr)
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.vertical, 4)
  }
}

#Preview {
  SkillListView()
}
