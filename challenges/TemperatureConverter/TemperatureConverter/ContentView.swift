//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Rodrigo Llaguno on 05/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var inputTemperature = 0.0
    @State private var inputUnits = "Celsius"
    @State private var outputUnits = "Farenheit"
    @FocusState private var amountIsFocused: Bool
    
    let unitType = ["Celsius", "Farenheit", "Kelvin"]
    
    var outputTemperature: Double{
        var tempCelsius = 0.0
        if inputUnits == "Farenheit"{
            tempCelsius = (inputTemperature - 32) * 5/9
        } else if inputUnits == "Kelvin"{
            tempCelsius = inputTemperature - 273.15
        } else{
            tempCelsius = inputTemperature
        }
        
        if outputUnits == "Farenheit" {
            return (tempCelsius * (9/5)) + 32
        } else if outputUnits == "Kelvin" {
            return tempCelsius + 273.15
        } else {
            return tempCelsius
        }
    }
    
    var body: some View {
        NavigationStack {
            Form{
                Section("Inputs:") {
                    TextField("Temperature value (°)", value: $inputTemperature, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    
                    Picker("Input Units", selection: $inputUnits){
                        ForEach(unitType, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.automatic)
                    
                    
                    Picker("Output Units", selection: $outputUnits){
                        ForEach(unitType, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.automatic)
                }
                
                Section("Output:") {
                    Text("\(outputTemperature.formatted())° \($outputUnits.wrappedValue)")
                }
                
            }
            .navigationTitle("Temperature Converter")
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
