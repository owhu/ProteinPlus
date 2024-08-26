//
//  ContentView.swift
//  ProteinPlus
//
//  Created by Oliver Hu on 8/9/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("total") private var total = 0 /*UserDefaults.standard.double(forKey: "savedTotal")*/
    @State private var proteinAmount = 1
    @AppStorage("lowerBound") private var lowerBound = 75
    @AppStorage("upperBound") private var upperBound = 90
    
    
    var body: some View {
        VStack {
            Image(.pixelPikachu)
                .resizable()
                .scaledToFit()
            Section{
                Picker("Protein", selection: $proteinAmount) {
                    ForEach(1..<81) { amount in
                        Text("^[\(amount) gram](inflect: true)")
                            .tag(amount)
                    }
                }
            }
            .pickerStyle(.wheel)
            Section {
                VStack {
                    
                    Button {
                        total += proteinAmount
                        //                    saveTotal()
                    } label: {
                        Image(systemName: "plus")
                            .padding()    // Add padding inside the button
                            .frame(minWidth: 100, minHeight: 50) // Set a minimum size for the button
                            .background(Color.yellow) // Optional: Change the background color
                            .foregroundColor(.black) // Change text and icon color
                            .cornerRadius(10) // Round the corners of the button
                    }
                    .padding()
                    .sensoryFeedback(.increase, trigger: total)
                    
                    Button {
                        total -= proteinAmount
                        //                    saveTotal()
                    } label: {
                        Image(systemName: "minus")
                            .padding()    // Add padding inside the button
                            .frame(minWidth: 100, minHeight: 50) // Set a minimum size for the button
                            .background(Color.yellow) // Optional: Change the background color
                            .foregroundColor(.black) // Change text and icon color
                            .cornerRadius(10) // Round the corners of the button
                    }
                    .padding()
                    .sensoryFeedback(.increase, trigger: total)
                    
                    
                    Button {
                        total = 0
                        //                        saveTotal()
                    } label: {
                        Label("Reset", systemImage: "restart.circle")
                            .padding()    // Add padding inside the button
                            .frame(minWidth: 100, minHeight: 50) // Set a minimum size for the button
                            .background(Color.yellow) // Optional: Change the background color
                            .foregroundColor(.white) // Change text and icon color
                            .cornerRadius(10) // Round the corners of the button
                    }
                    .padding()
                }
            }
            .padding()
            
            Section {
                VStack(alignment: .center) {
                    
                    Text("Total Protein:")
                        .font(.largeTitle)
                    HStack {
                        if total > 74 && total < 91 {
                            Image(systemName: "checkmark.circle.fill")
                        }
                        Text("\(total) \(total == 1 ? "gram" : "grams")")
                            .font(.largeTitle)
                            .bold()
                     
                    }
                    Text("Aim for range: \(lowerBound) - \(upperBound)")
                }
            }
            
            .padding()
            
        }
    }
    // Save the daily count to UserDefaults
    func saveTotal() {
        UserDefaults.standard.set(total, forKey: "total")
    }
    
    // Check if it's a new day and reset variables if necessary
    func checkIfNewDay() {
        let lastAccessDate = UserDefaults.standard.object(forKey: "lastAccessDate") as? Date ?? Date.distantPast
        
        if !Calendar.current.isDateInToday(lastAccessDate) {
            // Reset the variables for a new day
            total = 0
            UserDefaults.standard.set(Date(), forKey: "lastAccessDate")
        } else {
            // Load the saved count for the current day
            total = UserDefaults.standard.integer(forKey: "total")
        }
    }
//    private func saveTotal() {
//        UserDefaults.standard.set(total, forKey: "savedTotal")
//    }
}

#Preview {
    ContentView()
}
