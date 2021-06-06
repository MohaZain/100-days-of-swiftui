//
//  ContentView.swift
//  Edutainment
//
//  Created by mZain on 23/05/2021.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var isGameStart = false
    @State var tappCount = 1
    @State var qNum: Int = 5
//    @State var isEnd = ""
//    var isEnd: Int =  
    var body: some View {
        
        VStack(spacing:50){
//                Toggle("Start the game ?",isOn:$isGameStart)
//                    .frame()
            Spacer()
                if !isGameStart{
//                    <<<<<<<<<<<<<<CHOSE TABLE NUMBER>>>>>>>>>>>>>>>>
                    Section {
                            VStack(spacing:20){
                                    textFont(text: "TABLE NUMBER UP TO", color: "blue")
                                    ButtonTimes(tappCount: $tappCount)
                                            .animation(.easeIn)
                        }//end VStack
                    } //end <<<section>>>
//                    Text("------------------------------------------------------")
                    Text(" ")
//                    <<<<<<<<<<<<<<CHOSE TABLE NUMBER>>>>>>>>>>>>>>>>
                    Section{
                        VStack(spacing:30){
                                    textFont(text: "NUMBER OF QUESTION", color: "red")
                                    ButtonQuestion(qNum: $qNum,tableNum: $tappCount)
                        }//end VStack
                    }//end <<<section2>>>
//                    Toggle("Start the game ?",isOn:$isGameStart)
                    Spacer()
                    Button(action: {
                        isGameStart = true
                    }, label: {
                        HStack {
                            textFont(text: "START", color: "blue")
//                            CapsuleImage(image_name : "n")
//                            CapsuleImage(image_name : "t")
//                            CapsuleImage(image_name : "x")
//                            CapsuleImage(image_name : "t")
                        }
                        .frame(width: 190,height: 80,alignment: .center)
    //                                .border(Color.gray, width: 1)
                        .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.green, lineWidth: 1)
                            )
                    })

                }//end if
                
                else{
//                    <<<<<<<<<<<<<<PLAYING THE GAME HERE! AKA QUEZ START>>>>>>>>>>>>>>>>
                    GenrateQuestion(table: tappCount, numberOfQuestions: qNum, count1: 0)
//                    Spacer()
                }
                Spacer()
        } //end OF first VStack
    }//end of body
}//end of struct

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {

            ContentView()
    }
}
