//
//  Activity.swift
//  HabitTracking
//
//  Created by Rodrigo Llaguno on 05/08/24.
//

import Foundation

struct Activity: Identifiable, Codable, Hashable {
    var id = UUID()
    let title: String
    var description: String
    var iterations: Int
    
    var firstColor: Int
    var secondColor: Int
}
