//
//  ContentView.swift
//  WeSplit
//
//  Created by Rodrigo Llaguno on 03/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var amountOfPeople = 0
    @State private var tipPercentage = 15
    @FocusState private var amountIsFocused: Bool
    
    let currencyFormat = Locale.current.currency?.identifier ?? "USD"
    
    var total: Double {
        checkAmount + (checkAmount/100 * Double(tipPercentage))
    }
    var totalPerPerson: Double {
        let peopleCount = Double(amountOfPeople + 1)
        let amountPerPerson = total / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Check, number of people and tip:") {
                    TextField("Amount", value: $checkAmount, format: .currency(code: currencyFormat))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $amountOfPeople){
                        ForEach(1..<100){
                            if $0 == 1{
                                Text("\($0) person")
                            }else{
                                Text("\($0) people")
                            }
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(0..<101){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Total amount:") {
                    Text(total, format: .currency(code: currencyFormat))
                }
                
                Section("Total amount per person:") {
                    Text(totalPerPerson, format: .currency(code: currencyFormat))
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused{
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
