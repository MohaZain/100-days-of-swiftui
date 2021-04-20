//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by mZain on 05/04/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia",
                     "France",
                     "Germany",
                     "Ireland",
                     "Italy",
                     "Nigeria",
                     "Poland",
                     "Russia",
                     "Spain",
                     "UK",
                     "US"].shuffled()
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var message = ""
    @State private var scoreCount = 0

//    var x = countries.count
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        
        
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.gray, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing:30) {
                
                VStack {
                        Text("Tap the flag of !")
                            .foregroundColor(.white)
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.black)
                        }
            
                ForEach(0..<3){ i in
                    Button(action: {
                        self.flagTapped(i)
                    })
                        {
                        CapsuleImage(image_name : self.countries[i])
//                        Image(self.countries[i])
//                            .renderingMode(.original)
//                            .clipShape(Capsule())
//                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
//                            .shadow(color: .black, radius: 2)
                        }
                    }
                Text("Your Current Score is : \(scoreCount)")
                Spacer()
                    
                }
            }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(message), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
        }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreCount += 1
            message = "Your score is :\(scoreCount)"
        } else {
            scoreTitle = "Wrong"
            message = "this is \(countries[number]) && You reach to  :\(scoreCount)"
            scoreCount = 0
        }

        showingScore = true
        }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    }
struct CapsuleImage: View {
    var image_name: String

    var body: some View {
        Image(image_name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
