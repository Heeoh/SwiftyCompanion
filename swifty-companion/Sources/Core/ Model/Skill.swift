//
//  Skill.swift
//  swifty-companion
//
//  Created by Heeoh Son on 8/28/24.
//

import Foundation

typealias Skills = [Skill]
// MARK: - Skill
struct Skill: Codable, Equatable {
  let id: Int
  let name: String
  let level: Double
}
