//
//  ContentView.swift
//  WeSplit
//
//  Created by mZain on 01/04/2021.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var check_amount = ""
    @State private var no_of_people = ""
    @State private var tip_percentage_index = 2
    
    var totale_per_person:Double {
        let amount = Double(check_amount) ?? 0
//        if no_of_people is double this one will all
//        though we change it to string so we well do the same thing in check_amount
//        let count_people = Double(no_of_people)+2
        let count_people = Double(no_of_people) ?? 1
        let tip_perc = Double(tip_percentage[tip_percentage_index])
        let total_per = (amount + (amount / 100*tip_perc)) / count_people

        return total_per
    }
    var totale:Double {
        let amount = Double(check_amount) ?? 0
        let tip_perc = Double(tip_percentage[tip_percentage_index])

        let total = (amount + (amount / 100*tip_perc))
        return total
    }
    
    let tip_percentage = [10,15,20,25,0]
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                TextField("Amount ", text: $check_amount)
                    .keyboardType(.decimalPad)
                TextField("Number of people ", text: $no_of_people)
                    .keyboardType(.decimalPad)
//                    Picker("Number of people ", selection: $no_of_people){
//                        ForEach(2..<100){
//                            Text("\($0) People")
//                        }
//                    }
                }
                Section(header:Text("How much tip do you want to leave?")){
                    
                    Picker("Tip percentage :",selection:$tip_percentage_index){
                        ForEach(0..<tip_percentage.count){
                            Text("\(tip_percentage[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header:Text("Check Amount")){
                    Text("$\(totale, specifier: "%.2f")")
                        .foregroundColor(tip_percentage_index == 4 ? .red : .black)
                        
                    
                }
                Section(header:Text("Amount per person")){
                    Text("$\(totale_per_person, specifier: "%.2f")")
                }
                
            }.navigationBarTitle("We Split")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        }
    }

