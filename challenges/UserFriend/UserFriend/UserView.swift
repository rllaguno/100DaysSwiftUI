//
//  UserView.swift
//  UserFriend
//
//  Created by Rodrigo Llaguno on 16/08/24.
//

import SwiftUI

struct UserView: View {
    let user: User
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                ZStack {
                    Circle()
                        .fill(.black)
                        .frame(width: 50, height: 50) // adjust the size as needed
                    Image(systemName: "circle")
                        .foregroundColor(user.isActive == true ? .green : .gray)
                        .font(.system(size: 200, weight: .ultraLight))
                    
                    Text(user.shortName)
                        .font(.system(size:50))
                }
                Form {
                    Section("Basic Info") {
                        Text("Registered: \(user.formattedRegistered)")
                        Text("Age: \(user.age)")
                        Text("Email: \(user.email)")
                        Text("Address : \(user.address)")
                        Text("Works for: \(user.company)")
                    }
                    
                    Section("About") {
                        Text("\(user.about)")
                    }
                    
                    Section("Friends") {
                        ForEach(user.friends) { friend in
                            Text("\(friend.name)")
                        }
                    }
                }
            }
            .navigationTitle("Rodrigo Llaguno")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
