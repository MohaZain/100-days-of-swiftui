//
//  AddView.swift
//  iExpense
//
//  Created by mZain on 15/06/2021.
//

import SwiftUI

struct AddView: View {
        @ObservedObject var expenses: Expense
        @Environment(\.presentationMode) var presentationMode
//    Challenge 3
        @State var alertWrong = false
    
        @State var name : String = ""
        @State var type : String = "Personal"
        @State var amount : String = ""
        
        static let types = ["Business", "Personal"]
        
        var body: some View {
            NavigationView{
                Form{
                    TextField("Name", text: $name)
                    Picker("Type", selection: $type){
                        ForEach(Self.types, id: \.self){
                            Text($0)
                        }
                    }// picker type end
                    TextField("Amount", text: $amount)
                        .keyboardType(.numberPad)
                }
                .navigationBarItems(trailing: Button("Save") {
                    if let actualAmount = Int(self.amount) {
                        let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                        self.expenses.items.append(item)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    else {alertWrong = true}
                })
//                Challenge 3
                .alert(isPresented: $alertWrong) {
                    Alert(
                        title: Text("Wrong"),
                        message: Text("input exept intager number"),
                        dismissButton: .default(Text("Got it!"))
                    )
                }
                .navigationTitle("Add new expense")
            }
    //
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expense())
    }
}
