//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Rodrigo Llaguno on 06/07/24.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(.semibold))
            .foregroundColor(.white.opacity(0.9))
            .padding()
    }
}

struct FlagImage: View {
    var number: Int
    var countries: [String]
    
    var body: some View {
        Image(countries[number])
            .clipShape(.capsule)
            .shadow(radius: 10)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var finishedGame = false
    
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var gameCount = 0
    
    @State private var rotateAmount = 0.0
    @State private var opacityAmount = 1.0
    @State private var scaleAmount = 1.0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ] ,center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .titleStyle()
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            withAnimation(.bouncy) {
                                rotateAmount += 360
                            }
                            withAnimation(.spring(duration: 1, bounce: 0.7)) {
                                opacityAmount -= 0.75
                                scaleAmount -= 0.5
                            }
                        }
                         label: {
                             FlagImage(number: number, countries: countries)
                             
                        }
                         .opacity(correctAnswer == number ? 1 : opacityAmount)
                         .scaleEffect(correctAnswer == number ? 1 : scaleAmount)
                         .rotation3DEffect(.degrees(correctAnswer == number ? rotateAmount : 0), axis: (x: 0.0, y: 1.0, z: 0.0))

                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is: \(score)")
        }
        
        .alert(scoreTitle, isPresented: $finishedGame) {
            Button("Restart Game", action: reset)
        } message: {
            Text("Final Score: \(score)/\(gameCount)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong, that is the flag of \(countries[number])"
        }
        gameCount += 1
        
        if gameCount == 8 {
            scoreTitle += ", Game Finished"
            finishedGame = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacityAmount = 1.0
        rotateAmount = 0.0
        scaleAmount = 1.0
    }
    
    func reset() {
        askQuestion()
        score = 0
        gameCount = 0
    }
}

#Preview {
    ContentView()
}
