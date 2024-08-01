//
//  Mission.swift
//  Moonshot
//
//  Created by Rodrigo Llaguno on 26/07/24.
//

import Foundation

struct Mission: Hashable, Codable, Identifiable {
    struct CrewRole: Codable, Hashable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String{
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate:String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
