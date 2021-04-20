//
//  ContentView.swift
//  HeatConvertor
//  Temperature conversion
//  Created by mZain on 04/04/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var unit_index = 1
    @State private var no_number = ""
    let unit = ["C","F","K"]
    

    func calc_unit() -> (C:Double,F:Double,K:Double) {
        
        let num = Double(no_number) ?? 0
        var C :Double = num
        var F :Double = num
        var K :Double = num
        if unit[unit_index] == "C"{
            F = 9/5*(num) + 32
            K = num + 273
        }
        else if unit[unit_index] == "F"{
            C = (num - 32)/1.80
            K = 5/9*(num - 32) + 273.15
        }
        else if unit[unit_index] == "K"{
            C = num - 273
            F = 9/5*(num - 273) + 32
        }
        return (C,F,K)
    }
    var body: some View {
        NavigationView{
            Form{
                Section(header:Text("Unit Convertor from")){
                    Picker("Choose unit to convert from :",selection:$unit_index){
                        ForEach(0..<unit.count){
                            Text("\(unit[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header:Text("From \(unit[unit_index])")){
                    TextField("Unit number ", text:$no_number)
                }
                Section(header:Text("From \(unit[unit_index])")){
                    Text("Celsius: \(calc_unit().C,specifier: "%.2f")")
                    Text("Fahrenheit: \(calc_unit().F,specifier: "%.2f")")
                    Text("Kelvin: \(calc_unit().K,specifier: "%.2f")")
                }
        
            }.navigationBarTitle(Text("Temperature conversion"))
        }
        
}

    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

}
