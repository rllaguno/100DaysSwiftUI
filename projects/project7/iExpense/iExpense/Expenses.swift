//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Rodrigo Llaguno on 15/08/24.
//

import SwiftData
import Foundation

@Model
class Expenses {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    
    init(id: UUID = UUID(), name: String, type: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
    
}
