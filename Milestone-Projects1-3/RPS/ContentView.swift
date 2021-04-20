//
//  ContentView.swift
//  RPS
//
//  Created by mZain on 16/04/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var rand_move = Int.random(in: 0...2)
    @State private var should_win = Bool.random()
    @State private var massage = ""
    @State private var score = 0
    @State private var count = 0
    @State private var showingAlert = false
//    rps = ROCK PAPER SCISSOR
    let rps = ["Rock","Papper","Scissors"]
    var body: some View {
        VStack(spacing:10) {
            Text("The Computer is playing : \(rps[rand_move])")
            Text("You Should : \(should_win ? "WIN" : "LOSE")")
            
            HStack {
                ForEach(0..<3){ number in
                    Button(action : {
    //                    tappd
                        self.buttonTapped(number)
                        self.askQuestion()
                    }){
                        Text(rps[number])
                    }
                }
            }
            Text("You did : \(massage)")
            Text("Your Score is : \(score)")
            
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("GAME OVER YOU REACH 10 "),
                          message: Text("Your score is : \(score)"),dismissButton: .default(Text("Continue"))
                            {score = 0
                            massage = ""
                            }
                    )
                }
        }
    }
    func buttonTapped(_ number: Int){
//            0 = rock 1 = paper 2 = scissor
        
        if rand_move == 0 && should_win == true && number == 1{
            score += 1
            massage = "Good!"
        }
        else if rand_move == 0 && should_win == false && number == 2{
            score += 1
            massage = "Good!"
        }
//        paper
        else if rand_move == 1 && should_win == true && number == 2{
            score += 1
            massage = "Good!"
        }
        else if rand_move == 1 && should_win == false && number == 0{
            score += 1
            massage = "Good!"
        }
//        scissor
        else if rand_move == 2 && should_win == true && number == 0{
            score += 1
            massage = "Good!"
        }
        else if rand_move == 2 && should_win == false && number == 1{
            score += 1
            massage = "Good!"
        }
        else if rand_move == number {
            massage = "Tie"
        }
        else {
            score -= 1
            if score < 0 {score = 0}
            massage = "NOO!"
        }
    }
    func askQuestion(){
        count += 1
        if count == 10{
            showingAlert = true
        }
        
        rand_move = Int.random(in: 0...2)
        should_win = Bool.random()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
