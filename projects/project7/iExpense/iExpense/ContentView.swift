//
//  ContentView.swift
//  iExpense
//
//  Created by Rodrigo Llaguno on 21/07/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
        
    @State private var showingAddExpense = false

    @State private var filterOption = "Personal"
    @State private var sortOrder = [
        SortDescriptor(\Expenses.name),
        SortDescriptor(\Expenses.amount)
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ExpensesView(filter: filterOption, sortOrder: sortOrder)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
                
                Button {
                    if filterOption == "Personal" {
                        filterOption = "Business"
                    } else {
                        filterOption = "Personal"
                    }
                } label: {
                    Image(systemName: filterOption == "Personal" ? "house" : "network")
                }
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\Expenses.name),
                                SortDescriptor(\Expenses.amount)
                            ])
                        
                        Text("Sort by Amount")
                            .tag([
                                SortDescriptor(\Expenses.amount),
                                SortDescriptor(\Expenses.name)
                            ])
                    }
                }
                
            }
            .navigationDestination(isPresented: $showingAddExpense) {
                AddView()
            }
        }
    }
}

#Preview {
    ContentView()
}
