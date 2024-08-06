//
//  AddActivityView.swift
//  HabitTracking
//
//  Created by Rodrigo Llaguno on 05/08/24.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var description = ""
    
    var activities: Activities
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Habit Title", text: $title)
                
                ZStack {
                    if description.isEmpty {
                        Text("Habit description")
                            .foregroundColor(.gray)
                            .padding(8)
                    }
                    
                    TextEditor(text: $description)
                        .frame(height: 200)
                }
                
            }
            .navigationTitle("Add new habit")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Save") {
                            let item = Activity(title: title, description: description, iterations: 0, firstColor: Int.random(in: 0...6), secondColor: Int.random(in: 0...6))
                            activities.items.append(item)
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
                .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    AddActivityView(activities: Activities())
}
