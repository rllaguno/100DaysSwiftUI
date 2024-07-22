//
//  AddView.swift
//  iExpense
//
//  Created by Rodrigo Llaguno on 22/07/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    var expenses: Expenses
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add a new expense")
            .toolbar {
                Button("Save") {
                    if let amountDouble = Double(amount) {
                        let item = ExpenseItem(name: name, type: type, amount: amountDouble)
                        expenses.items.append(item)
                    }

                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}