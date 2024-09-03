//
//  HelpMeRememberApp.swift
//  HelpMeRemember
//
//  Created by Rodrigo Llaguno on 02/09/24.
//

import SwiftData
import SwiftUI

@main
struct HelpMeRememberApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Remember.self)
    }
}
