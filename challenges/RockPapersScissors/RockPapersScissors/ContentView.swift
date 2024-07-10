//
//  ContentView.swift
//  RockPapersScissors
//
//  Created by Rodrigo Llaguno on 10/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var options: [String] = ["🪨", "📃", "✂️"]
    
    @State private var move: Int = Int.random(in: 0...2)
    @State private var shouldWin: Bool = Bool.random()
    
    @State private var score: Int = 0
    @State private var correct: Int = 0
    @State private var gameCount: Int = 0
    
    @State private var gameOver: Bool = false

    
    var body: some View {
        ZStack {
            RadialGradient( stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: .black, location: 0.3)
                ] ,center: .bottom, startRadius: 100, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Rock, Paper, Scissors")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                
                Spacer()
                Spacer()
                
                VStack(spacing: 10) {
                    Text("Choose the option to \(shouldWin == true ? "win" : "lose") against: ")
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .semibold))
                    
                    Text(options[move])
                        .font(.system(size: 80))
                }
                .frame(maxWidth: 300, maxHeight: 200)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))

                
                Spacer()
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(.white)

                Spacer()
                
                HStack {
                    ForEach(0..<3) { number in
                        Button {
                            choiceTapped(number)
                        } label: {
                            Text("\(options[number])")
                                .font(.system(size: 80))
                                .padding()
                        }
                        
                    }
                }
            }
        }
        .alert("Game Over", isPresented: $gameOver) {
            Button("Restart Game", action: reset)
        } message: {
            Text("Your final score was: \(score)")
                + Text("\n")
                + Text("\(correct) out of 10 answers correctly.")
        }
    }
    
    func determineExpectedAnswer() -> Int{
        if shouldWin {
            return determineWinningMove()
        } else {
            return determineLosingMove()
        }
    }
    
    func determineWinningMove() -> Int {
        switch move{
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 0
        default:
            return 0
        }
    }
    
    func determineLosingMove() -> Int {
        switch move{
        case 0:
            return 2
        case 1:
            return 0
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func choiceTapped(_ number: Int) {
        let expectedAnswer = determineExpectedAnswer()
        
        if expectedAnswer == number {
            score += 1
            correct += 1
        } else {
            score -= 1
        }
        
        gameCount += 1
        
        if gameCount == 10 {
            gameOver = true
            return
        }
        shouldWin.toggle()
        askQuestion()
    }
    
    func askQuestion() {
        move = Int.random(in: 0...2)
    }
    
    func reset() {
        askQuestion()
        correct = 0
        score = 0
        gameCount = 0
    }
}

#Preview {
    ContentView()
}
