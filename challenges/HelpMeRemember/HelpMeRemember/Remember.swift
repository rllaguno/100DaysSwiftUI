//
//  Remember.swift
//  HelpMeRemember
//
//  Created by Rodrigo Llaguno on 02/09/24.
//

import Foundation
import SwiftData
import SwiftUI
import UIKit

@Model
class Remember: Identifiable, Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case registered = "registered"
        case photo = "photo"
    }
    
    var id: UUID
    var name: String
    var registered: Date
    @Attribute(.externalStorage) var photo: Data
    
    func convert() -> Image {
        if let uiImage = UIImage(data: photo) {
            return Image(uiImage: uiImage)
        }
        return Image(systemName: "questionmark.square.dashed")
    }
    
    static func <(lhs: Remember, rhs: Remember) -> Bool {
        lhs.name < rhs.name
    }
    
    init(name: String, photo: Data) {
        self.id = UUID()
        self.name = name
        self.registered = Date.now
        self.photo = photo
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.registered = try container.decode(Date.self, forKey: .registered)
        self.photo = try container.decode(Data.self, forKey: .photo)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.registered, forKey: .registered)
        try container.encode(self.photo, forKey: .photo)
    }
    
}
