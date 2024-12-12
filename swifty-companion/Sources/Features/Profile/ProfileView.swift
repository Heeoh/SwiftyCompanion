//
//  ProfileView.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/19/24.
//

import SwiftUI
import ComposableArchitecture

struct ProfileImageView: View {
  let imageUrl: String?
  let name: String
  let size: CGFloat
  
  init(imageUrl: String?, name: String, size: CGFloat = 96) {
    self.imageUrl = imageUrl
    self.name = name
    self.size = size
  }
  
  var body: some View {
    Group {
      if let url = URL(string: imageUrl ?? "") {
        AsyncImage(url: url) { phase in
          if let image = phase.image {
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
          } else if phase.error != nil {
            defaultImage
          } else {
            ProgressView()
              .frame(width: size, height: size)
              .cornerRadius(size / 2)
          }
        }
      } else {
        defaultImage
      }
    }
    .frame(width: size, height: size)
    .clipped()
    .cornerRadius(size / 2)
  }
  
  private var defaultImage: some View {
    Circle()
      .foregroundColor(.black)
      .frame(width: size, height: size)
      .overlay {
        Text(name.prefix(2).uppercased())
          .foregroundColor(.white)
          .font(.system(size: size / 4))
      }
  }
}

struct ProfileView: View {
  let login: String
  let isMyProfile: Bool
  
  let store = Store(initialState: ProfileFeature.State()) {
    ProfileFeature()
  }
  let projectStore = Store(initialState: ProjectListFeature.State()) {
    ProjectListFeature()
  }
  
  let slidingToggleStore = Store(initialState: SlidingToggleCore.State(items: ["Projects", "Skills", "Stat"])) {
    SlidingToggleCore()
  }
  
  
  @Environment(\.dismiss) var dismiss
  
  init(login: String) {
    self.login = login
    self.isMyProfile = AuthFeature.State.userData.login == login
  }
  
  var body: some View {
    let profileImageUrl = store.userData.image.link
    let intraID = self.login
    let fullName = store.userData.displayname
    
    let grade = store.userData.mainCursusUser?.grade ?? "novice"
    let level = store.userData.mainCursusUser?.level ?? 0.0
    let neverAbsorbed = store.userData.mainCursusUser?.neverAbsorbed ?? false
    let daysUntilblackhole = store.userData.mainCursusUser?.daysUntilBlackhole ?? 1
    let daysSinceStartCursus = store.userData.mainCursusUser?.daysSinceStartCursus ?? 0
    
    
    VStack {
      CustomNavigationBar(rightButton: {
        if isMyProfile {
          SystemIconButton("rectangle.portrait.and.arrow.right", color: isMyProfile ? Color.white : Color.clear) {
            print("logout")
          }.disabled(!isMyProfile)
        }
      })
      
      VStack {
        ProfileImageView(imageUrl: profileImageUrl, name: login)
          .padding()
        Text(intraID)
          .font(.headline)
          .foregroundColor(.white)
        Text(fullName)
          .font(.subheadline)
          .foregroundColor(.white)
      }
      
      HStack(alignment: .center, spacing: 15) {
        dataTileView(title: "grade", value: grade)
        verticalDivider(width: 1, height: 30, color: .white.opacity(0.6))
        dataTileView(title: "level", value: "Lv. \(String(format: "%.2f", level))")
        verticalDivider(width: 1, height: 30, color: .white.opacity(0.6))
        if neverAbsorbed {
          dataTileView(title: "uptime", value: "D+\(daysSinceStartCursus)")
        } else {
          let blackholeState = daysUntilblackhole > 0 ? "Absorbed" : daysUntilblackhole == 0 ? "Today" : "D\(daysUntilblackhole)"
          dataTileView(title: "blackhole", value: blackholeState)
        }
      }
      .padding(.vertical, 20)
      .frame(maxWidth: .infinity)
      .cornerRadius(16)
      .padding(.horizontal, Layout.side)
      .padding(.top, 12)
      .padding(.bottom, 20)
      
      
      Spacer()
    }
    .background(Image("sky").resizable().clipped())
    .ignoresSafeArea()
    .onAppear {
      store.send(.fetchUserData(self.login))
      projectStore.send(.fetchProjectListOfUser(login: self.login))
    }
    .sheet(isPresented: .constant(true)) {
      sheetContentView
        .presentationDetents([.fraction(0.55), .fraction(0.9)])
        .interactiveDismissDisabled()
        .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.55)))
    }
  }
  
  var sheetContentView: some View {
    ScrollView {
      VStack(spacing: 10) {
        SlidingToggleView(store: slidingToggleStore)
          .frame(height: 50)
          .padding(.bottom, 20)
        
        if slidingToggleStore.tappedItem == "Projects" {
          ProjectListView(store: projectStore)
        } else {
          Text("Skill List")
        }
      }
      .padding(.horizontal, Layout.side)
    }
    .padding(.top, 30)
    .background(Color(hex: "FAFAFA"))
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
  ProfileView(login: "heson")
}
