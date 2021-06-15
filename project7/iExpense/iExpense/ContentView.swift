//
//  ContentView.swift
//  iExpense
//
//  Created by mZain on 13/06/2021.
//

import SwiftUI

//struct User: Codable {
//    var firstName: String
//    var lastName: String
//}
struct ContentView: View {
    @ObservedObject var expenses = Expense()
    @State var showingAddView = false
//    @State private var user = User(firstName: "Taylor", lastName: "Swift")

//    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
//    @State private var numbers = [Int]()
//    @State private var currentNumber = 1
//

//    function to allow delete from list by swap Left
    func removeRows(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    var body: some View {
        NavigationView{
            List{
                ForEach(expenses.items){ item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                        Text("$\(item.amount)")
                    }
                }.onDelete(perform: removeRows)
            }
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.showingAddView = true
//                                        let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
//                                        self.expenses.items.append(expense)
                                    }) {
                                        Image(systemName: "plus")
                                    }
                                )
            .navigationTitle("iExpense")
        }.sheet(isPresented: $showingAddView) {
            AddView(expenses: self.expenses)
        }
//        Button("Save User") {
//            let encoder = JSONEncoder()
//
//            if let data = try? encoder.encode(self.user) {
//                UserDefaults.standard.set(data, forKey: "UserData")
//            }
//        }
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
