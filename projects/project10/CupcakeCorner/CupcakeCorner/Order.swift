//
//  Order.swift
//  CupcakeCorner
//
//  Created by Rodrigo Llaguno on 06/08/24.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"
    }
    
    private enum UserDefaultsKeys: String {
        case name, streetAddress, city, zip
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = "" {
        didSet {
            saveToUserDefaults(key: .name, value: name)
        }
    }
        
    var streetAddress = "" {
        didSet {
            saveToUserDefaults(key: .streetAddress, value: streetAddress)
        }
    }
    
    var city = "" {
        didSet {
            saveToUserDefaults(key: .city, value: city)
        }
    }
    
    var zip = "" {
        didSet {
            saveToUserDefaults(key: .zip, value: zip)
        }
    }
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty || name.hasPrefix(" ") || streetAddress.hasPrefix(" ") || city.hasPrefix(" ") || zip.hasPrefix(" "){
            return false
        }
        
        return true
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity * 2)
        
        cost += Decimal(type) / 2
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if addSprinkles {
            cost += Decimal(quantity)/2
        }
        
        return cost
    }
    
    init() {
        name = loadFromUserDefaults(key: .name) ?? ""
        streetAddress = loadFromUserDefaults(key: .streetAddress) ?? ""
        city = loadFromUserDefaults(key: .city) ?? ""
        zip = loadFromUserDefaults(key: .zip) ?? ""
    }
    
    private func saveToUserDefaults(key: UserDefaultsKeys, value: String) {
        if let encoded = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(encoded, forKey: key.rawValue)
        }
    }
    
    private func loadFromUserDefaults(key: UserDefaultsKeys) -> String? {
        if let data = UserDefaults.standard.data(forKey: key.rawValue),
           let decoded = try? JSONDecoder().decode(String.self, from: data) {
            return decoded
        }
        return nil
    }
    
}
