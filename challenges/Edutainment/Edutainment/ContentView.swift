//
//  ContentView.swift
//  Edutainment
//
//  Created by Rodrigo Llaguno on 20/07/24.
//

import SwiftUI

extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))}
}

enum appView {
    case settings, game, end
}

struct Question {
    let question: String
    let answer: Int
    
}

struct ContentView: View {
    let numExcercises: [Int] = [5, 10, 20]
    
    @State private var view: appView = appView.settings
    
    @State private var timesTable: Int = 2
    @State private var numChosen: Int = 0
    @State private var questions: [Question] = []
    @State private var answer: Int = 1
    @State private var numProblem: Int = 0
    
    @State private var score: Int = 0
    
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        
        ZStack {
            //Settings View
            if view == appView.settings {
                LinearGradient(colors: [.blue, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                    .overlay(
                        VStack {
                            
                            Text("Set up game:")
                                .font(.title)
                                .foregroundStyle(.primary)
                                .padding()
                            
                            Stepper("Times table of: \(timesTable)", value: $timesTable, in: 2...12, step: 1)
                                .padding(.horizontal)
                            
                            HStack {
                                Text("Number of excersises: ")
                                
                                Picker("Number of excersises: ", selection: $numChosen) {
                                    ForEach(0..<3) {
                                        Text("\(numExcercises[$0])")
                                    }
                                }
                                .pickerStyle(.segmented)
                            }
                            .padding(.horizontal)
                            
                            Button{
                                generateQuestions()
                                view = appView.game
                            } label: {
                                Text("Start Game")
                                    .padding()
                            }
                        }
                            .animation(.default, value: timesTable)
                            .frame(maxWidth: 350, maxHeight: 300)
                            .background(.thinMaterial)
                            .clipShape(.rect(cornerRadius: 20))
                            .offset(dragAmount)
                            .gesture(
                                DragGesture()
                                    .onChanged { dragAmount = $0.translation }
                                    .onEnded { _ in
                                        withAnimation(.bouncy) {
                                            dragAmount = .zero
                                        }
                                    }
                            )
                    )
                    .transition(.backslide)
            }
            
            //Game View
            if view == appView.game {
                LinearGradient(colors: [.green, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                    .overlay(
                        HStack {
                            
                            Text(questions[numProblem].question)
                            
                            Picker("Answer", selection: $answer) {
                                ForEach(1..<144, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(.wheel)
                            
                            Button {
                                nextQuestion()
                            } label: {
                                Text(numProblem == (numExcercises[numChosen] - 1) ? "Finish" : "Next")
                            }
                        }
                            .animation(.default, value: questions[numProblem].question)
                            .padding()
                    )
                    .transition(.backslide)
            }
            
            //End View
            if view == appView.end {
                
                LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                    .overlay(
                        VStack{
                            Text("Final Score is \(score) out of \(numExcercises[numChosen]) correct")
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .padding()
                            Button {
                                restartGame()
                            } label: {
                                Text("Restart Game")
                                
                            }
                        }
                            .frame(maxWidth: 300, maxHeight: 200)
                            .background(.thinMaterial)
                            .clipShape(.rect(cornerRadius: 20))
                            .offset(dragAmount)
                            .gesture(
                                DragGesture()
                                    .onChanged { dragAmount = $0.translation }
                                    .onEnded { _ in
                                        withAnimation(.bouncy) {
                                            dragAmount = .zero
                                        }
                                    }
                            )
                    )
                    .transition(.backslide)
            }
            
        }
        .animation(.easeInOut(duration: 1), value: view)
    }
    
    func generateQuestions() {
        for _ in 1...numExcercises[numChosen] {
            let multiplier = Int.random(in: 1...12)
            let answer = timesTable * multiplier
            let question = "\(timesTable) x \(multiplier) = "
            questions.append(Question(question: question, answer: answer))
        }
    }
    
    func nextQuestion() {
        if answer == questions[numProblem].answer {
            score += 1
        }
        numProblem += 1
        answer = 1
        
        if numProblem == numExcercises[numChosen] {
            view = appView.end
        }
    }
    
    func restartGame() {
        score = 0
        numProblem = 0
        questions.removeAll()
        numChosen = 0
        timesTable = 2
        
        view = appView.settings
    }
}


#Preview {
    ContentView()
}
