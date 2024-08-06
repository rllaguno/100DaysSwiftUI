//
//  ActivityDetailView.swift
//  HabitTracking
//
//  Created by Rodrigo Llaguno on 05/08/24.
//

import SwiftUI

struct ActivityDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State private var iterations: Int
    
    let colors = [Color.red, Color.yellow, Color.blue, Color.green, Color.purple, Color.orange, Color.pink]


    var activity: Activity
    
    init(activity: Activity) {
        self.activity = activity
        _iterations = State(initialValue: activity.iterations)
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 50) {
                ZStack {
                    LinearGradient(colors: [colors[activity.firstColor], colors[activity.secondColor]], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .clipShape(Circle())
                    Text(activity.description)
                        .padding(.horizontal, 30)
                        .font(.title2)
                }
                
            }
            .padding()
            .navigationTitle(activity.title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                        
                    }
                }
            }
        }
    
    }

}

#Preview {
    let item = Activity(title: "Sleep", description: "I want to sleep 8 hours a day.", iterations: 0, firstColor: 1, secondColor: 2)
    return ActivityDetailView(activity: item)
}
