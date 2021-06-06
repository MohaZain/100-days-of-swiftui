//
//  ButtonQuestion.swift
//  Edutainment
//
//  Created by mZain on 26/05/2021.
//

import SwiftUI

struct ButtonQuestion: View {
    
    @Binding var qNum: Int
    @Binding var tableNum: Int
    
    @State  var attempts: Int = 0
    @State  var animationFade = [true,true,true,true]
    
    func AnimationFade(index:Int)  {
        self.animationFade = [true,true,true,true]
        
        if index == 0 {
//            self.animationFade = [true,true,true,true]
            self.animationFade[0] = false
        }
        else if index == 1{
            self.animationFade[1] = false
        }

        else if index == 2 {
            self.animationFade[2] = false
        }
        else if index == 3{
            self.animationFade[3] = false
        }
        
    }
    
    var body: some View {
//        VStack(spacing:15) {
//            hsstack for 5,10,20
            HStack(spacing:30) {
                Button(action: {
                    self.qNum = 5
                    AnimationFade(index: 0)
                }, label: {
                    CapsuleImage(image_name : "num5")
                        .frame(width: 100,height: 68)
                        .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.red, lineWidth: 1)
                            )
//                        .animation(.easeIn)
                        .opacity(animationFade[0] ? 1 : 0.35)
                        .animation(.easeOut)
                }) //end button
                Button(action: {
                    self.qNum = 10
                    AnimationFade(index: 1)
                }, label: {
                    HStack{
                        CapsuleImage(image_name : "num1")
                        CapsuleImage(image_name : "num0")
                    }
                    .frame(width: 100,height: 70,alignment: .center)
                    .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.blue, lineWidth: 1)
                        )
//                    .animation(.easeIn)
                    .opacity(animationFade[1] ? 1 : 0.35)
                    .animation(.easeOut)
                    
                }) //end button
                Button(action: {
                    if tableNum == 1{self.qNum = 11}
                    else {self.qNum = 20}
                    AnimationFade(index: 2)
                    
                }, label: {
                    HStack{
                        CapsuleImage(image_name : "num2")
                        CapsuleImage(image_name : "num0")
                    }
                    .frame(width: 100,height: 70,alignment: .center)
//                                .border(Color.gray, width: 1)
                    .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.green, lineWidth: 1)
                        )
                    .animation(.easeIn)
                    .opacity(animationFade[2] ? 1 : 0.35)
                    .animation(.easeOut)
                }) //end button
            } //end of hstack
                Button(action: {
                    self.qNum = tableNum * 12
                    AnimationFade(index: 3)
                }, label: {
                    HStack {
                        Text("ALL THE QUESTIONS") 
                            .font(.system(size: 24))
//                            .fontWeight(.bold)
                            .font(.system(.title, design: .rounded))
                            .foregroundColor(.orange)
//                            .shadow(color: .red, radius: 1)
//                        CapsuleImage(image_name : "num8")
//                        CapsuleImage(image_name : "num0")
                    }
                            .frame(width: 350,height: 68)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.yellow, lineWidth: 1)
                                )
                            .animation(.easeIn)
                            .opacity(animationFade[3] ? 1 : 0.35)
                            .animation(.easeOut)
                        
                }) //end button
//            Text("\(qNum)")
//        } //end of VStack
    }
}

//struct ButtonQuestion_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonQuestion()
//    }
//}
