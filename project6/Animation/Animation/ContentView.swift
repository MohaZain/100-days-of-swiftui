//
//  ContentView.swift
//  Animation
//
//  Created by mZain on 11/05/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var anmationAmount : CGFloat = 1
    var body: some View {

        Button("Tap me"){
            self.anmationAmount += 1
        }
        .padding()
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        .scaleEffect(anmationAmount)
        .animation(.default)
        .blur(radius: (anmationAmount - 1) * 3)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
