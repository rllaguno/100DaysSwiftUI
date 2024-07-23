//
//  ContentView.swift
//  iExpense
//
//  Created by Rodrigo Llaguno on 21/07/24.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    @State private var personalSum = 0.0
    @State private var businessSum = 0.0

    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("Personal Expenses")
                        .font(.headline)
                    
                    ForEach(expenses.items) { item in
                        if item.type == "Personal" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    Text(item.type)
                                }
                                
                                Spacer()
                                HStack {
                                    Text(item.amount, format: .currency(code: "MXN"))
                                    
                                    if item.amount < 10.0 {
                                        Image(systemName: "exclamationmark.square")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.green)
                                    } else if item.amount > 10.0 && item.amount < 100.0 {
                                        Image(systemName: "exclamationmark.square")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.yellow)
                                    } else {
                                        Image(systemName: "exclamationmark.square")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                            .onAppear(perform: getPersonalExpense)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                
                Section {
                    
                    Text("Business Expenses")
                        .font(.headline)
                    
                    ForEach(expenses.items) { item in
                        if item.type == "Business" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    Text(item.type)
                                }
                                
                                Spacer()
                                HStack {
                                    Text(item.amount, format: .currency(code: "MXN"))
                                    
                                    if item.amount < 10.0 {
                                        Image(systemName: "exclamationmark.square")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.green)
                                    } else if item.amount > 10.0 && item.amount < 100.0 {
                                        Image(systemName: "exclamationmark.square")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.yellow)
                                    } else {
                                        Image(systemName: "exclamationmark.square")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                            .onAppear(perform: getBusinessExpense)
                        }
                    }
                    .onDelete(perform: removeItems)

                }
                
                Section {
                    Text("Total Expenses")
                        .font(.headline)
                    
                    HStack {
                        Text("Personal")
                        
                        Spacer()
                        
                        Text(personalSum, format: .currency(code: "MXN"))
                            .onAppear{
                                getPersonalExpense()
                            }
                    }
                    
                    HStack {
                        Text("Business")
                        
                        Spacer()
                        
                        Text(businessSum, format: .currency(code: "MXN"))

                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
        getPersonalExpense()
        getBusinessExpense()
    }
    
    func getPersonalExpense(){
        personalSum = 0.0
        for i in expenses.items {
            if i.type == "Personal" {
                personalSum += i.amount
            }
        }
        
    }
    
    func getBusinessExpense(){
        businessSum = 0.0
        for i in expenses.items {
            if i.type == "Business" {
                businessSum += i.amount
            }
        }
        
    }
}

#Preview {
    ContentView()
}
