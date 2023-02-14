//
//  ContentView.swift
//  BetterRest
//
//  Created by Thaddäus Schima on 13.02.23.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    var body: some View {
        NavigationView {
            VStack {
                Text("When do you want to wake up?")
                    .font(.headline)
                
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                Stepper(coffeeAmountText(), value: $coffeeAmount, in: 0...12)
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
            }.navigationTitle("BetterRest")
                .toolbar {
                    Button("Calculate", action: calculateBedTime)
                }
        }
        
    }
    func coffeeAmountText() -> String{
        if coffeeAmount == 1 {
            return "\(coffeeAmount) cup"
        } else {
            return "\(coffeeAmount) cups"
        }
    }
    func calculateBedTime() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
