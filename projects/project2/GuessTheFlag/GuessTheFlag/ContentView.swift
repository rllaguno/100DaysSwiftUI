//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Rodrigo Llaguno on 06/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Your content")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 0.1, green: 0.5, blue: 0.3).gradient)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
