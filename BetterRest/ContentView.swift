//
//  ContentView.swift
//  BetterRest
//
//  Created by Thaddäus Schima on 13.02.23.
//

import SwiftUI

struct ContentView: View {
    var components = Calendar.current.dateComponents([.hour, .minute], from: someDate)
    let hour = components.hour ?? 0
    let minute = components.minute ?? 0
    let date = Calendar.current.date(from: components) ?? Date.now
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    var body: some View {
        VStack {
            Stepper("\(sleepAmount.formatted()) hours", value:$sleepAmount, in: 4...12, step: 0.25)
            DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...).labelsHidden()
            Text(Date.now, format: .dateTime.day().month().year())
            Text(Date.now.formatted(date: .long, time: .shortened))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
