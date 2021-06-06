//
//  GenrateQuestion.swift
//  Edutainment
//
//  Created by mZain on 31/05/2021.
//

import SwiftUI
//import Foundation

struct Question {
    var text: String
    var result: String
}
struct GenrateQuestion:View {
    @State var uAnswer = ""
    
    @State var countCorrect = 0
    @State var countWrong = 0
//    @State var count = 0
//    question count bar
    @State var qustionCount : CGFloat = 0
    var number : CGFloat =  0
//    let barCount:CGFloat
    var questionsList = [Question]()
    var qNum : Int = 5
    @State var count : Int = 0
//    @Binding var isEnd = ""
    @State var showingScore = false
//    @State var goBack = false
    @State var scoreTitle : String = "Good Keep learning <3"
    @State var message = "5/5"
    init(table: Int , numberOfQuestions: Int, count1: Int) {
//        isEnd = end
//        questionsList = generateQuestions(table: table, numberOfQuestions: numberOfQuestions)
        questionsList = generateQuestions(table: table, numberOfQuestions: numberOfQuestions)
        qNum = numberOfQuestions
        count = count1
        number = 400/CGFloat(qNum)
//        barCount = CGFloat(qNum/400)

    }
    
//    Genrating question
    func generateQuestions(table: Int, numberOfQuestions: Int) -> [Question] {
        var tmbquestionsList = [Question]()
//        var resultList = [Int]()
        
        for i in 1...table {
            for j in 1...12 {
                if j >= i {
                    let result = String(i * j)
                    tmbquestionsList.append(Question(text: "\(i) x \(j) =", result: result))
                    
                    if i != j {
                        tmbquestionsList.append(Question(text: "\(i) x \(j) =", result: result))
                    }

                }
            }
        }

        tmbquestionsList.shuffle()
        return Array(tmbquestionsList[0..<numberOfQuestions])
    }
    
     func CheckAnswer() {
//        if qustion result is equal your result then count correct answer else count wrong answer
        let x = uAnswer
        if Int(questionsList[count].result) == Int(x){
            countCorrect += 1
        }
        else{
            countWrong += 1
        }
//        qustionCount += barCount
        count += 1
        uAnswer = ""
        if count == qNum {
            ShoeAlert()
            showingScore = true
        }
    }
    func ShoeAlert(){
        if Double(countCorrect) == Double(qNum){
            scoreTitle = "Awsome"
        }
        else if Double(countCorrect) > Double(qNum/2){
            scoreTitle = "You Did Great"
        }
        else{
            scoreTitle = "Practice don't Give up"
        }
        message = "\(countCorrect)/\(qNum)"
//        showingScore = true
    }
    var body: some View {

        VStack {

            if count < qNum {
                VStack{
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                        Capsule()
                            .fill(Color.gray.opacity(0.5))
                            .frame(height: 6)
                        Capsule()
                            .fill(Color.green)
                            .frame(width: qustionCount, height: 6)
                            .animation(.easeIn)
                    }.padding()
                    HStack {
                        Label(
                            title: { Text("\(countCorrect)")
                                .font(.largeTitle)
                                .foregroundColor(.black)
    //                            .animation(.easeIn)
                            },
                            icon: { Image(systemName: "checkmark")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                            }
                        )
                        Spacer()
                        
                        Label(
                            title: { Text("\(countWrong)")
                                .font(.largeTitle)
                                .foregroundColor(.black)
    //                            .animation(.easeIn)
                            },
                            icon: { Image(systemName: "xmark")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                            }
                        )
    //                    Text("\(countCorrect)------------\(countWrong)")
                    }
                    .padding(.horizontal)
                }
                .frame(height: 50)
                Spacer()
                HStack {
//                    \(questionsList[count].result)
//                    Text("\(questionsList[count].text)")
                    textFont(text: "       \(questionsList[count].text)", color: "red")
                    TextField("Here", text: $uAnswer, onCommit: CheckAnswer)
                        .keyboardType(.numberPad)
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                        .frame(width: 100.0, height: 40)
                }
                Spacer(minLength: 180)

//                Text("\(countCorrect)------------\(countWrong)")
                Button(action: {
                    CheckAnswer()
                    uAnswer = ""
                    qustionCount += number
                }, label: {
                    HStack {
                        CapsuleImage(image_name : "n")
                        CapsuleImage(image_name : "e")
                        CapsuleImage(image_name : "x")
                        CapsuleImage(image_name : "t")
                    }
                    .frame(width: 250,height: 80,alignment: .center)
//                                .border(Color.gray, width: 1)
                    .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.green, lineWidth: 1)
                        )
                })
                Spacer()

            }
            else if count == qNum {
//                Spacer()
                VStack(spacing:40){
                    CapsuleImageAlert(image_name : "winner")
                    Text(scoreTitle)
//                        .fontWeight(.bold)
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundColor(.orange)
                    Text(message)
//                        .fontWeight(.bold)
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundColor(.green)
                    Spacer()

                }
                Button(action: {
                    count += 1
                }, label: {
                    HStack {
                       Text("PLAY AGAIN")
//                            .fontWeight(.bold)
                        .font(.system(.title, design: .rounded))
                        .foregroundColor(Color.orange)
//                            .background(Color.black)
                        .shadow(color: .orange, radius: 1)
                    }

                })
            }
            
            else if count > qNum{
                ContentView()
            }
        }
//        .alert(isPresented: $showingScore) {
//                    Alert(title: Text(scoreTitle), message: Text(message), dismissButton: .default(Text("Continue")))
//                }
    }
}
struct CapsuleImageAlert: View {
    var image_name: String

    var body: some View {
        Image(image_name)
            .resizable()
            .frame(width: 150, height: 150)
    }
}
struct GenrateQuestion_Previews: PreviewProvider {
    static var previews: some View {
        GenrateQuestion(table: 7, numberOfQuestions: 5,count1: 0)
    }
}
