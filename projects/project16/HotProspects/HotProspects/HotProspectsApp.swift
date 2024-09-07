//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Rodrigo Llaguno on 04/09/24.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
