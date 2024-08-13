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
    
    var body: some View {
        VStack {
            Image(.pixelPikachu)
                .resizable()
                .scaledToFit()
            Section{
                Picker("Protein", selection: $proteinAmount) {
                    ForEach(1..<81) { amount in
                        Text("^[\(amount) gram](inflect: true)")
//                            .tag(Double(amount))
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
                    Text("\(total) \(total == 1 ? "gram" : "grams")")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(total > 76 && total < 93 ? .green : .red)
                    Text("Aim for range: 77 - 92")
                }
            }
            
            .padding()
            
        }
    }
//    private func saveTotal() {
//        UserDefaults.standard.set(total, forKey: "savedTotal")
//    }
}

#Preview {
    ContentView()
}
