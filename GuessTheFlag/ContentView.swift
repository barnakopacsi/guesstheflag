//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kopácsi Barna Martin on 2025. 05. 04..
//
// Copyright © 2025 [Kopácsi Barna Martin]. All rights reserved.
// This work is licensed under the Creative Commons Attribution-NonCommercial 4.0 International License.
// You may not use this material for commercial purposes without obtaining permission from the author.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userScore = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var questionCount = 0
    @State private var gameIsOver = false
    @State private var gameOver = ""
    @State private var userAnswer = 0
    
struct FlagImage: View {
    var imageName: String
        
    var body: some View {
            Image(imageName)
                .clipShape(.capsule)
                .shadow(radius: 5)
    }
}
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: .teal, location: 0.23),
                .init(color: .orange, location: 0.33)
            ], center: .top, startRadius: 235, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
            VStack(spacing: 15) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.secondary)
                        .font(.subheadline.weight(.heavy))
                    
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                }
                
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        FlagImage(imageName: countries[number])
                    }
                }
            }
            .frame(maxWidth: 350)
            .padding(.vertical, 25)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 50))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if  scoreTitle == "Correct!" {
            Text("Your score is \(userScore)!")
            } else {
                Text("You chose the flag of \(countries[userAnswer])! The flag of \(countries[correctAnswer]) was the \(positionText(for: correctAnswer)) flag.")
            }
        }
        .alert(gameOver, isPresented: $gameIsOver) {
            Button("New game", action: resetGame)
        } message: {
            Text("Your final score is \(userScore)/8!")
        }
    }
    
    func addPoint(_ number: Int) {
        if number == correctAnswer {
            userScore += 1
       }
    }
    
    func addQuestion(_ number: Int) {
        questionCount += 1
    }
    
    func positionText(for number: Int) -> String {
        switch number {
        case 0: return "1st"
        case 1: return "2nd"
        default: return "3rd"
        }
    }
    
    func flagTapped(_ number: Int) {
        userAnswer = number
        if number == correctAnswer {
            scoreTitle = "Correct!"
        } else {
            scoreTitle = "Wrong!"
        }
        addQuestion(number)
        addPoint(number)
        if questionCount < 8 {
                showingScore = true
            } else {
                gameOver = "Game over!"
                gameIsOver = true
            }
    }
    
    func resetGame() {
            gameIsOver = false
            questionCount = 0
            userScore = 0
            askQuestion()
  }
    
    func askQuestion() {
        if questionCount < 8 {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        } else {
            gameOver = "Game over!"
            gameIsOver = true
        }
    }
}

#Preview {
    ContentView()
}
