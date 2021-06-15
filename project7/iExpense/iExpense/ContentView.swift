//
//  ContentView.swift
//  iExpense
//
//  Created by mZain on 13/06/2021.
//

import SwiftUI

// Challenge 2
struct TextColor: View {
    var num: Int

    var body: some View {
        if num <= 10 {
            Text("\(num)")
                .foregroundColor(.green)
        }
        if num > 10 &&  num <= 100{
            Text("\(num)")
                .foregroundColor(.blue)
        }
        if num > 100 {
            Text("\(num)")
                .foregroundColor(.red)
        }
    }
}
struct ContentView: View {
    @ObservedObject var expenses = Expense()
    @State var showingAddView = false

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
                        TextColor(num: item.amount)
                        
                    }
                }.onDelete(perform: removeRows)
            }
            .navigationBarItems(leading:
                                    Button(action: {
                                        self.showingAddView = true
                                        
                                    }) {
                                        Image(systemName: "plus")
                                    },
//                                Challenge 1
                                trailing: EditButton()
                                )
            .navigationTitle("iExpense")
        }.sheet(isPresented: $showingAddView) {
            AddView(expenses: self.expenses)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
