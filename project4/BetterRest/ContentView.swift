//
//  ContentView.swift
//  BetterRest
//
//  Created by mZain on 18/04/2021.
//

import SwiftUI

struct ContentView: View {
    
    static var defaultWakeTime: Date {
         var components = DateComponents()
         components.hour = 7
         components.minute = 20
         return Calendar.current.date(from: components) ?? Date()
     }
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    let model = SleepCalculator()
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    var beddtime: String {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        var mss : String
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short

            mss = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is…"

            // more code here
        } catch {
            // something went wrong!
            alertTitle = "Error"
            mss = "Sorry, there was a problem calculating your bedtime."
        }
        return mss
    }
    var body: some View {
        NavigationView{
            Form {
                Section{
                    DatePicker("Please Enter a time", selection: $wakeUp , displayedComponents: .hourAndMinute)
//                        .labelsHidden()
                        .font(.headline)
                }
                Section {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper(value: $sleepAmount, in : 4...12, step: 0.25){
                        Text("\(sleepAmount , specifier: "%g") hours")
                    }
                }
                Section {
                    Text("Daily coffee intake")
                        .font(.headline)
                    Stepper(value: $coffeeAmount, in : 1...20){
                        Text("\(coffeeAmount) \(coffeeAmount == 1 ? "Cup" : "Cups")")
                    }
//              Daily coffee intake same from the previews stepper but with picker !
                    Picker("Daily coffee intake", selection: $coffeeAmount) {
                        ForEach(1..<21) {
                            Text("\($0)")
                        }
                    }
                }
                .navigationBarItems(trailing:
                    Button(action : calculateBedtime) {
                      Text("Calculate")
                    }
                )
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                HStack {
                    Text("Your ideal bedtime is…")
                    Text("\(beddtime)")
//                       .onTapGesture{
//                        self.calculateBedtime() }
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }
    func calculateBedtime() {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short

            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is…"

            // more code here
        } catch {
            // something went wrong!
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
