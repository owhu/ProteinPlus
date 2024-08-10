//
//  ContentView.swift
//  ProteinPlus
//
//  Created by Oliver Hu on 8/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var total = UserDefaults.standard.double(forKey: "savedTotal")
    @State private var proteinAmount = 1.0
    
    var body: some View {
        VStack {
            Image(.pixelPikachu)
                .resizable()
                .scaledToFit()
            Section{
                Picker("Protein", selection: $proteinAmount) {
                    ForEach(1..<80) { amount in
                        Text("\(amount) gram(s)").tag(Double(amount))
                    }
                }
            }
            .pickerStyle(.wheel)
            Section {
                Button {
                    total += proteinAmount
                    saveTotal()
                } label: {
                    Image(systemName: "plus")
                        .padding()    // Add padding inside the button
                        .frame(minWidth: 100, minHeight: 50) // Set a minimum size for the button
                        .background(Color.blue) // Optional: Change the background color
                        .foregroundColor(.white) // Change text and icon color
                        .cornerRadius(10) // Round the corners of the button
                }
            }
            .padding()
            Section {
                Text("Total Protein: \(total, specifier: "%.1f") grams")
            }
            .bold()
            .padding()
            
            Button {
                 total = 0.0
                 saveTotal()
             } label: {
                 Label("Reset", systemImage: "restart.circle")
                     .padding()    // Add padding inside the button
                     .frame(minWidth: 100, minHeight: 50) // Set a minimum size for the button
                     .background(Color.blue) // Optional: Change the background color
                     .foregroundColor(.white) // Change text and icon color
                     .cornerRadius(10) // Round the corners of the button
             }

        }
    }
    private func saveTotal() {
        UserDefaults.standard.set(total, forKey: "savedTotal")
    }
}

#Preview {
    ContentView()
}
