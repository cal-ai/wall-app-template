//
//  Post.swift
//  WallAppTemplate
//
//  Created by Wahab on 16/07/2024.
//
import Foundation
struct Post: Identifiable, Codable {
  let id: String
  let userId: String
  let userName: String
  let userProfileImage: String
  let content: String
  let timestamp: TimeInterval

  enum CodingKeys: String, CodingKey {
    case id,content, timestamp
    case userId = "user_id"
    case userName = "user_name"
    case userProfileImage = "profile_image"

  }
  init(id: String, userId: String, userName: String, userProfileImage: String, content: String, timestamp: TimeInterval) {
    self.id = id
    self.userId = userId
    self.userName = userName
    self.userProfileImage = userProfileImage
    self.content = content
    self.timestamp = timestamp
  }
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(String.self, forKey: .id)
    self.content = try container.decode(String.self, forKey: .content)
    self.timestamp = try container.decode(TimeInterval.self, forKey: .timestamp)
    self.userId = try container.decode(String.self, forKey: .userId)
    self.userName = try container.decode(String.self, forKey: .userName)
    self.userProfileImage = try container.decode(String.self, forKey: .userProfileImage)
  }
}

extension Encodable {
  var dict: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
