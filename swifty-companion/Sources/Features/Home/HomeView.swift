//
//  HomeView.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/21/24.
//

import SwiftUI
import ComposableArchitecture

struct SearchRowView: View {
  let image: String?
  let name: String
  
  init(user: SimpleUser) {
    self.image = user.image.link
    self.name = user.login
  }
  
  init(project: Project) {
    self.image = nil
    self.name = project.name
  }
  
  var body: some View {
    HStack(spacing: 12) {
      ProfileImageView(imageUrl: image, name: name, size: 32)
      Text("\(name)")
        .frame(maxWidth: .infinity, alignment: .leading)
      Spacer()
      Image(systemName: "chevron.right")
    }
    .foregroundColor(.black)
    .frame(maxWidth: .infinity)
    .frame(height: 36)
  }
}

enum HomeRoute: Hashable {
  case myPage
  case userPage(of: String)
  case projectPage(of: String)
}

struct HomeView: View {
//  @State var store: StoreOf<SearchCore>
  @State var store = Store(initialState: SearchCore.State()) {
      SearchCore()
  }
  
  // navigation stack
  @State var path = NavigationPath()
  
  var body: some View {
    NavigationStack(path: $path) {
      
      VStack(spacing: 0) {
        CustomNavigationBar(rightButton: {
          SystemIconButton("person.crop.circle", color: .white, size: 24) {
            path.append(HomeRoute.myPage)
          }
        })
        
        
        VStack {
//          Text(AuthFeature.State.userData.login)
//            .foregroundColor(.white)
          
          SearchBarView(store: store)
            .padding(.top, store.isShowingResults == true ? 20 : 0)
            .padding(.bottom, store.isShowingResults == true ? 20 : 100)
            .onChange(of: store.query) {
              store.send(.showResults, animation: .spring())
            }
          
          VStack(spacing: 0) {
            if store.isShowingResults {
              searchResultView
                .transition(.move(edge: .bottom))
 
              Spacer()
            }
          }
        }
        .padding(.horizontal, Layout.side)
        .frame(maxHeight: .infinity)
      }
      .background(Image("sky").resizable().clipped())
      .ignoresSafeArea()
      .navigationDestination(for: HomeRoute.self) { stackViewType in
        switch stackViewType {
        case .myPage:
          ProfileView(login: AuthFeature.State.userData.login)
            .navigationBarBackButtonHidden()
        case .userPage(let userName):
          ProfileView(login: userName)
            .navigationBarBackButtonHidden()
        case .projectPage(let projectName):
          ProjectView(name: projectName)
            .navigationBarBackButtonHidden()
        }
      }
    }
  }
  
  var searchResultView: some View {
    VStack {
      if !store.userResult.isEmpty {
        sectionHeaderView(headerStr: "유저")
        VStack(spacing: 4) {
          ForEach(store.userResult, id: \.id) { aUser in
            Button {
              path.append(HomeRoute.userPage(of: aUser.login))
            } label: { SearchRowView(user: aUser) }
          }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.bottom, 20)
      }
      
      if !store.projectResult.isEmpty {
        sectionHeaderView(headerStr: "프로젝트")
        VStack(spacing: 4) {
          ForEach(store.projectResult, id: \.id) { aProject in
            Button {
              path.append(HomeRoute.projectPage(of: aProject.name))
            } label: { SearchRowView(project: aProject) }
          }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.bottom, 20)
      }
    }
    .padding()
    .frame(maxWidth: .infinity)
    .background(Color.white)
    .cornerRadius(24)
  }
  
  func sectionHeaderView(headerStr: String) -> some View {
    VStack {
      Text(headerStr)
        .font(.subheadline)
        .foregroundColor(.black.opacity(0.7))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 4)
      Divider()
        .padding(.bottom, 4)
    }
  }
}

#Preview {
  HomeView()
//  HomeView(
//    store: Store(initialState: SearchCore.State()) {
//      SearchCore()
//    }
//  )
}

