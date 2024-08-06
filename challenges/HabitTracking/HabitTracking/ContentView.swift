//
//  ContentView.swift
//  HabitTracking
//
//  Created by Rodrigo Llaguno on 01/08/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var activities = Activities()
    
    let colors = [Color.red, Color.yellow, Color.blue, Color.green, Color.purple, Color.orange, Color.pink]
    
    @State private var showingAddActity = false
    @State private var showingActivityDetail = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 50) {
                    Spacer()
                    ForEach(activities.items) { activity in
                        NavigationLink(destination: ActivityDetailView(activity: activity)) {
                            ZStack(alignment: .topLeading) {
                                LinearGradient(colors: [colors[activity.firstColor], colors[activity.secondColor]], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    .frame(width: 300, height: 180)
                                    .clipShape(.rect(cornerRadius: 40))
                                
                                VStack(alignment: .leading) {
                                    Text(activity.title)
                                        .padding(25)
                                        .font(.title.bold())
                                        .foregroundStyle(.white)
                                    
                                    HStack {
                                        Text("Iterations: \(activity.iterations)")
                                            .font(.headline)
                                            .foregroundStyle(.white)
                                        
                                        Image(systemName: "arrow.right")
                                            .foregroundStyle(.white)
                                    }
                                    .padding([.leading, .trailing], 90)
                                }
                            }
                        }
                    }
                    
                }
            }
            .navigationTitle("HabitTracking")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddActity = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showingAddActity) {
                        AddActivityView(activities: activities)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
