//
//  User.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/28/24.
//

import SwiftUI

typealias Users = [User]
typealias SimpleUsers = [SimpleUser]

struct User: Codable, Equatable {
  var id: Int? = nil
  var login: String = "Intra ID"
  var url: String = ""
  var displayname: String = "User Name"
  var image: ProfileImage = ProfileImage()
  var cursusUser: [CursusUser] = []
  var mainCursusUser: CursusUser? {
    let arr = cursusUser.filter{ $0.cursus.kind ?? "" == "main" }
    return arr.isEmpty ? nil : arr[0]
  }
  
  enum CodingKeys: String, CodingKey {
    case id, login, url, displayname, image, cursusUser = "cursus_users"
  }
}

struct SimpleUser: Codable, Equatable {
  var id: Int? = nil
  var login: String = ""
  var image: ProfileImage = ProfileImage()
}

// MARK: - Profile Image
struct ProfileImage: Codable, Equatable {
  var link: String? = nil
}

// MARK: - Cursus User
enum CursusName {
  case piscineC
  case cursus42
  case noName
}

struct Cursus: Codable, Equatable {
  var id: Int?
  var name: String? // C Piscine / 42cursus
  var kind: String?
  var cursusName: CursusName {
    switch (self.name ?? "") {
    case "C Piscine": return .piscineC
    case "42cursus": return .cursus42
    default: return .noName
    }
  }
}

struct CursusUser: Codable, Equatable {
  var id: Int? = nil
  var grade: String? = nil
  var level: Double = 0.0
  var skills: [Skill] = []
  var cursus: Cursus
  var blackholeAt: String?
  var beginAt: String?
  
  var neverAbsorbed: Bool {
    return blackholeAt == nil
  }
  var daysUntilBlackhole: Int {
    guard let days = DateFormatManager().daysFromToday(to: self.blackholeAt) else {
      return 1
    }
    return days - 1
  }
  var daysSinceStartCursus: Int {
    return DateFormatManager().daysFromToday(to: self.beginAt) ?? 0
  }
  
  enum CodingKeys: String, CodingKey {
    case id, grade, level, skills, cursus
    case blackholeAt = "blackholed_at"
    case beginAt = "begin_at"
  }
}

struct DateFormatManager {
  // DateFormatter를 사용해 문자열을 Date 객체로 변환
  let dateFormatter = ISO8601DateFormatter()
  
  init() {
    dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
  }

  // 문자열을 Date로 변환
  func StringToDate(dateString: String?) -> Date? {
    return dateFormatter.date(from: dateString ?? "")
  }
  
  // 오늘로부터 며칠 남았는지 혹은 며칠 지났는지 구하는 함수
  func daysFromToday(to: String?) -> Int? {
    guard let targetDate = dateFormatter.date(from: to ?? "") else {
      return nil
    }
    let currentDate = Date()
    
    // 날짜 계산할 calender
    let calendar = Calendar.current
    
    // 날짜 차이를 일(day) 단위로 계산
    guard let daysDifference = calendar.dateComponents([.day], from: targetDate, to: currentDate).day else {
      return nil
    }
    
    return daysDifference
  }
}

//curl -H "Authorization: Bearer 433a73ed9048a8e9e297f90013af13655268d16caba12190074acfc5645c7e55" https://api.intra.42.fr/v2/users?filter[user_id]=110933/cursus_users

