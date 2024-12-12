//
//  Project.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/20/24.
//

import Foundation

typealias ProjectUsers = [ProjectUser]
typealias Projects = [Project]

// MARK: - Project USer
struct ProjectUser: Codable, Equatable {
  let id, occurrence: Int
  let finalMark: Int?
  let status: ProjectStatus
  // let validated: Bool?
  // let currentTeamID: Int
  let project: Project
  let cursusIDs: [Int]
  let marked: Bool
  let markedAt: String?
  let createdAt, updatedAt: String
  // let retriableAt: String?
  
  
  enum CodingKeys: String, CodingKey {
    case id, occurrence
    case finalMark = "final_mark"
    case status
    // case validated = "validated?"
    // case currentTeamID = "current_team_id"
    case project
    case cursusIDs = "cursus_ids"
    case marked
    case markedAt = "marked_at"
    // case retriableAt = "retriable_at"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
  }
}

// MARK: - Project Status
enum ProjectStatus: String, Codable {
  case finished = "finished"
  case inProgress = "in_progress"
  case waitingForCorrection = "waiting_for_correction"
}

// MARK: - Project
struct Project: Codable, Equatable {
    let id: Int
    let name: String
}
