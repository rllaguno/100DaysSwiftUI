//
//  ContentView.swift
//  UserFriend
//
//  Created by Rodrigo Llaguno on 16/08/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    NavigationLink(destination: UserView(user: user)) {
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(.black)
                                    .frame(width: 50, height: 50) // adjust the size as needed
                                Image(systemName: "circle")
                                    .foregroundColor(user.isActive == true ? .green : .gray)
                                    .font(.system(size: 50, weight: .thin))
                                
                                Text(user.shortName)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(user.name)
                                    .fontWeight(.bold)
                                Text(user.isActive == true ? "Active" : "Offline")
                                    .foregroundStyle(user.isActive == true ? .green : .gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("UserFriend")
            .task {
                if users.isEmpty {
                    await loadData()
                }
            }
        }
    }
    
    func loadData() async {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedData = try decoder.decode([User].self, from: data)
            for user in decodedData {
                modelContext.insert(user)
            }
        } catch {
            print(error)
        }
    }
}

#Preview {
    ContentView()
}
