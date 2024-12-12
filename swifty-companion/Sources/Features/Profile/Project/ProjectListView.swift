//
//  ProjectListView.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/20/24.
//

import SwiftUI
import ComposableArchitecture

struct SectionView<Content: View>: View {
  let headerStr: String
  let content: () -> Content
  
  var body: some View {
    Section(header: sectionHeaderView(headerStr: headerStr)) {
      VStack {
        content()
      }
      .padding()
      .background(Color.white)
      .cornerRadius(Radius.medium)
      .shadow(
        color: Color.black.opacity(0.1),
        radius: 10,
        y: 8
      )
      .padding(.bottom, 20)
    }
  }
}

extension SectionView {
  func sectionHeaderView(headerStr: String) -> some View {
    Text(headerStr)
      .font(.subheadline)
      .foregroundColor(.black.opacity(0.7))
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.vertical, 4)
  }
}

struct ProjectListView: View {
  let store: StoreOf<ProjectListFeature>

  var body: some View {
    SectionView(headerStr: "진행 중인 과제") {
      Group {
        if store.isLoading {
          ProgressView()
        } else if store.inProgressProjectList.isEmpty {
          Text("진행 중인 과제가 없습니다.")
        } else {
          VStack(spacing: 4) {
            ForEach(store.inProgressProjectList, id: \.self.id) { aProject in
              let projectName = aProject.project.name
              inProgressProjectView(name: projectName)
            }
          }
        }
      }
      .frame(maxWidth: .infinity, alignment: .center)
      .frame(minHeight: 80)
    }
    
    SectionView(headerStr: "완료한 과제") {
      Group {
        if store.isLoading {
          ProgressView()
        } else if store.completedProjectList.isEmpty {
          Text("완료한 과제가 없습니다.")
        } else {
          VStack {
            ForEach(store.completedProjectList, id: \.self.id) { aProject in
              let projectName = aProject.project.name
              let markedScore = aProject.finalMark ?? 0
              completedProjectView(name: projectName, markedScore: markedScore)
            }
          }
        }
      }
      .frame(maxWidth: .infinity, alignment: .center)
      .frame(minHeight: 80)
    }
  }
  
  func inProgressProjectView(name: String) -> some View {
    HStack {
      Text(name)
      
//      Text("exam")
//        .padding(6)
//        .overlay {
//          RoundedRectangle(cornerRadius:  Radius.large)
//            .foregroundColor(Color.red.opacity(0.3))
//        }
//      Text("retry")
//        .padding(6)
//        .overlay {
//          RoundedRectangle(cornerRadius:  Radius.large)
//            .foregroundColor(Color.blue.opacity(0.3))
//        }
      
      Spacer()
      
      SystemIconButton("chevron.right") {
          
      }
    }
    .font(.body)
    .frame(height: 36)
//      .background(Color.red)
  }
  
  func completedProjectView(name: String, markedScore: Int) -> some View {
    HStack {
      Text(name)
      
//      Text("retry")
//        .frame(height: 12)
//        .padding(8)
//        .overlay {
//          RoundedRectangle(cornerRadius:  Radius.medium)
//            .foregroundColor(Color.yellow.opacity(0.3))
//        }
//      Text("exam")
//        .padding(6)
//        .overlay {
//          RoundedRectangle(cornerRadius:  Radius.large)
//            .foregroundColor(Color.red.opacity(0.3))
//        }
      Spacer()
      Text("\(markedScore)")
      SystemIconButton("chevron.right") {
          
      }

    }.frame(height: 36)
  }
}
