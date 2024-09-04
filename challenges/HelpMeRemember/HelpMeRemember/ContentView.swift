//
//  ContentView.swift
//  HelpMeRemember
//
//  Created by Rodrigo Llaguno on 02/09/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Remember.name) var remembers: [Remember]
    @State private var showingAddRemember = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(remembers) { remember in
                    NavigationLink(destination: RememberView(remember: remember)) {
                        HStack(spacing: 10) {
                            remember.convert()
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                            
                            Text(remember.name)
                                .fontWeight(.bold)
                        }
                    }
                }
            }
            .navigationTitle("HelpMeRemember")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddRemember = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showingAddRemember) {
                        AddRememberView()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
