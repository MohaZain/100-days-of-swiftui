//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by mZain on 05/04/2021.
//
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
//    challange for project 6 rotaion , fade and shake error
    @State private var ifCorrect = false
    @State private var animationAmount = [0.0, 0.0, 0.0]
    
    @State private var animationFade = [true, true, true]
//    var x = countries.count
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var attempts: Int = 0
    
    struct Shake: GeometryEffect {
        var amount: CGFloat = 10
        var shakesPerUnit = 3
        var animatableData: CGFloat

        func effectValue(size: CGSize) -> ProjectionTransform {
            ProjectionTransform(CGAffineTransform(translationX:
                amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
                y: 0))
        }
    }
    
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
                                .rotation3DEffect(.degrees(animationAmount[i]), axis: (x: 0, y: 1, z: 0))
                                .animation(
                                    Animation.easeInOut(duration: 1)
                                        .repeatCount(1, autoreverses: true)
                                ).opacity(animationFade[i] ? 1 : 0.25)
                                .modifier(Shake(animatableData: CGFloat(attempts)))
                        
                                
                           
//                        Image(self.countries[i])
//                            .renderingMode(.original)
//                            .clipShape(Capsule())
//                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
//                            .shadow(color: .black, radius: 2)
                    }
                    
                    
                        

                    }
                Text("Your Current Score is : \(scoreCount)")
                    .foregroundColor(.white)
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
        
//        withAnimation(Animation.easeInOut(duration: 0.5)) {
//                  self.animateOpacity = true
//        }
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreCount += 1
            message = "Your score is :\(scoreCount)"
            ifCorrect = true
            withAnimation {
                self.animationAmount[number] += 360
                animationFade = [false, false, false]
                self.animationFade[number] = true
                
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.askQuestion()
            }
            
        } else {
            scoreTitle = "Wrong"
            message = "this is \(countries[number]) && You reach to  :\(scoreCount)"
            scoreCount = 0
            ifCorrect = false
            
            withAnimation(.default) {
                                self.attempts += 1
                            }
            
        }
        
        showingScore = true
        }
    
    func askQuestion() {
//        animationAmount = 0
        animationFade = [true, true, true]
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
