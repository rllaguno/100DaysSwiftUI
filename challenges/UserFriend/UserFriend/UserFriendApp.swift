//
//  UserFriendApp.swift
//  UserFriend
//
//  Created by Rodrigo Llaguno on 16/08/24.
//

import SwiftData
import SwiftUI

@main
struct UserFriendApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
