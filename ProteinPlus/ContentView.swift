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
                } label: {
                    Image(systemName: "plus")
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
