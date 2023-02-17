//
//  ContentView.swift
//  BetterRest
//
//  Created by Thaddäus Schima on 13.02.23.
//
import CoreML
import SwiftUI

struct ContentView: View {
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    var body: some View {
        NavigationView {
            Form {
                Section("How much do you wanna sleep?") {
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                Section("How many coffees did you drink?") {
                    Stepper(coffeeAmountText(), value: $coffeeAmount, in: 0...12)
                    Picker("How much Coffee do you drunk: ", selection: $coffeeAmount) {
                        ForEach(0...12, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                Section("Wann willst du aufstehen?") {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section("optimale Einschlafzeit:") {
                    Text(calculateBedTime()).font(.largeTitle)
                }
                
                
            }.navigationTitle("BetterRest")
                
        }
        
    }
    func coffeeAmountText() -> String{
        if coffeeAmount == 1 {
            return "\(coffeeAmount) cup"
        } else {
            return "\(coffeeAmount) cups"
        }
    }
    func calculateBedTime() -> String{
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return """
            Error,
            Sorry, there was a problem calculating your bedtime
            """
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
