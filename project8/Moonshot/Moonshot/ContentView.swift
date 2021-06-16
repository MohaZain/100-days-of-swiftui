//
//  ContentView.swift
//  Moonshot
//
//  Created by mZain on 16/06/2021.
//

import SwiftUI
 
struct ContentView: View {
    var body: some View {
        
        NavigationView {
            List(0..<100) { row in
                NavigationLink(destination: Text("Detail \(row)")) {
                    Text("Row \(row)")
                }
            }
            .navigationBarTitle("SwiftUI")
        }
//        ScrollView(.vertical) {
//            VStack(spacing: 10) {
//                ForEach(0..<100) {
//                    Text("Item \($0)")
//                        .font(.title)
//                }
//            }
//            .frame(maxWidth: .infinity)
//        }
//        GeometryReader { geo in
//            Image(systemName:"error")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: geo.size.width)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
