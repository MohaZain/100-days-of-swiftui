//
//  ContentView.swift
//  iExpense
//
//  Created by mZain on 13/06/2021.
//

import SwiftUI

struct User: Codable {
    var firstName: String
    var lastName: String
}
struct ContentView: View {
    @State private var user = User(firstName: "Taylor", lastName: "Swift")

//    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
//    @State private var numbers = [Int]()
//    @State private var currentNumber = 1
//
//    func removeRows(at offsets: IndexSet) {
//        numbers.remove(atOffsets: offsets)
//    }
    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()

            if let data = try? encoder.encode(self.user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
//        NavigationView{
//            VStack {
//                List {
//                    ForEach(numbers, id: \.self) {
//                        Text("\($0)")
//                    }
//                    .onDelete(perform: removeRows)
//                }
//
//                Button("Add Number") {
//                    self.numbers.append(self.currentNumber)
//                    self.currentNumber += 1
//                }
//            }
//            .navigationBarItems(leading: EditButton())
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
