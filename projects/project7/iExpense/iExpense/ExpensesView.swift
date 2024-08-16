//
//  ExpensesView.swift
//  iExpense
//
//  Created by Rodrigo Llaguno on 15/08/24.
//

import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext

    @Query var expenses: [Expenses]
    @State private var personalSum = 0.0
    @State private var businessSum = 0.0
    
    var body: some View {
        Section {
            Text("Personal Expenses")
                .font(.headline)
            
            ForEach(expenses) { item in
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
            
            ForEach(expenses) { item in
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
    
    init(filter: String, sortOrder: [SortDescriptor<Expenses>]) {
        _expenses = Query(filter: #Predicate<Expenses> { expense in
            expense.type == filter
        }, sort: sortOrder)
    }
    
    
    func removeItems(at offsets: IndexSet) {
        for index in offsets {
            let item = expenses[index]
            modelContext.delete(item)
        }
        getPersonalExpense()
        getBusinessExpense()
    }
    
    func getPersonalExpense(){
        personalSum = 0.0
        for i in expenses {
            if i.type == "Personal" {
                personalSum += i.amount
            }
        }
        
    }
    
    func getBusinessExpense(){
        businessSum = 0.0
        for i in expenses {
            if i.type == "Business" {
                businessSum += i.amount
            }
        }
        
    }
}
