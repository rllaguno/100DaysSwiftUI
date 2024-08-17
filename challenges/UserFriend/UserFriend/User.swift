//
//  User.swift
//  UserFriend
//
//  Created by Rodrigo Llaguno on 16/08/24.
//

import Foundation
import SwiftData

@Model
class User: Codable, Identifiable, Hashable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case isActive = "isActive"
        case age = "age"
        case name = "name"
        case company = "company"
        case email = "email"
        case address = "address"
        case about = "about"
        case registered = "registered"
        case tags = "tags"
        case friends = "friends"
    }
    
    var id: UUID
    
    var isActive: Bool
    
    var age: Int
    
    var name: String
    var shortName: String {
        if name.isEmpty {
            return ""
        } else {
            let components = name.components(separatedBy: " ")
            let firstLetter = "\(components[0][components[0].startIndex])"
            let lastLetter = "\(components[1][components[1].startIndex])"
            return "\(firstLetter)\(lastLetter)"
        }
    }
    var company: String
    var email: String
    var address: String
    var about: String
    
    var registered: Date
    var formattedRegistered: String {
        registered.formatted(date: .complete, time: .omitted)
    }
    
    var tags: [String]
    var friends: [Friend]
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.age = try container.decode(Int.self, forKey: .age)
        self.name = try container.decode(String.self, forKey: .name)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.registered = try container.decode(Date.self, forKey: .registered)
        self.tags = try container.decode([String].self, forKey: .tags)
        self.friends = try container.decode([Friend].self, forKey: .friends)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.isActive, forKey: .isActive)
        try container.encode(self.age, forKey: .age)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.company, forKey: .company)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.address, forKey: .address)
        try container.encode(self.about, forKey: .about)
        try container.encode(self.registered, forKey: .registered)
        try container.encode(self.tags, forKey: .tags)
        try container.encode(self.friends, forKey: .friends)
    }
    

    
}
