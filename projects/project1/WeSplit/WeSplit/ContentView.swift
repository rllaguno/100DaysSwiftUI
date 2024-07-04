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
    
    let tipPercentages = [10, 15, 20, 25, 0]
    let currencyFormat = Locale.current.currency?.identifier ?? "USD"
    
    var totalPerPerson: Double {
        let peopleCount = Double(amountOfPeople + 1)
        let tipSelection = Double(tipPercentage)
        
        let total = checkAmount + (checkAmount/100 * tipSelection)
        let amountPerPerson = total / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Check and number of people:") {
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
                }
                
                Section("Tip percentage:") {
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
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
