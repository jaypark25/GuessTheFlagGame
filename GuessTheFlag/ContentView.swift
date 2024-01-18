//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jay Park on 2024-01-13.
//

import SwiftUI

struct FlagImage:  View {
    var text : String
    var body : some View {
        Image(text)
            .clipShape(.capsule)
            .shadow(radius : 5)
    }
}

struct TitleText: View {
    var text : String
    var body : some View {
        Text(text)
            .foregroundStyle(.blue)
        

            
    }
}

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State var score = 0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var correct = true
    
    
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location : 0.3),
                .init(color: Color(red: 0.78, green :0.15, blue : 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                TitleText(text : "Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text ("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.semibold))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                        
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label : {
                            FlagImage(text : countries[number])
                        }
                        
                    }
                }
                .frame(maxWidth : .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                
                Text ("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
            
                    }
        .alert(scoreTitle, isPresented : $showingScore) {
            Button("Continue", action : askQuestion)
        } message: {
            if (correct) {
                Text("Your score is \(score)")
            } else {
                Text("The correct answer is \(countries[correctAnswer])")
            }
            
            
            
        }
    }
    
    func flagTapped(_ number : Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            correct = true
        } else {
            scoreTitle = "Wrong"
            correct = false
        }
        showingScore = true
        
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in : 0...2)
    }
}

#Preview {
    ContentView()
}
