//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Rodrigo Llaguno on 21/07/24.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expenses.self)
    }
}
