//
//  User.swift
//  UserFriend
//
//  Created by Rodrigo Llaguno on 16/08/24.
//

import Foundation

class User: Codable, Identifiable, Hashable {
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
    
}
