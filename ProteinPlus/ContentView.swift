//
//  ContentView.swift
//  ProteinPlus
//
//  Created by Oliver Hu on 8/9/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("total") private var total = 0
    @AppStorage("upperBound") private var upperBound = 90
    
    @State private var proteinAmount = 1
    @State var progressValue: Float = 0.0
    
    @State private var showingEditView = false

    
    var body: some View {
        VStack {
            ZStack {
                ProgressView(progress: self.$progressValue)
                    .frame(width: 160.0, height: 160.0)
                    .padding(.top, 20)
                    .onAppear {
                        self.progressValue = progressValue
                    }
                VStack {
                    HStack {
                        if total >= upperBound {
                            Image(systemName: "checkmark.circle.fill")
                        }
                        Text("\(total) g")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    
//                    Text("Goal: \(upperBound) g")
//                        .font(.subheadline)
//                        .foregroundStyle(.gray)
                    
                    Button("Goal: \(upperBound) g") {
                        showingEditView = true
                    }
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .sheet(isPresented: $showingEditView) {
                        EditUpperBoundView(upperBound: $upperBound)
                            .presentationDetents([.height(300)])
                    }
                }
                .padding(.top)
            }
            .padding(.top)
            
       
            
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
                        withAnimation(.easeInOut(duration: 2.0)) {
                            total += proteinAmount
                            progressValue += (Float(proteinAmount)) / Float(upperBound)
                        }

                    } label: {
                        Image(systemName: "plus")
                            .padding()    // Add padding inside the button
                            .frame(width: 75, height: 60) // Set a minimum size for the button
                            .background(Color.yellow) // Optional: Change the background color
                            .foregroundColor(.black) // Change text and icon color
                            .cornerRadius(10) // Round the corners of the button
                    }
                    .padding()
                    .sensoryFeedback(.increase, trigger: total)

                    Button {
                        withAnimation(.easeInOut(duration: 2.0)) {
                            total -= proteinAmount
                            progressValue -= (Float(proteinAmount)) / Float(upperBound)
                        }
                    } label: {
                        Image(systemName: "minus")
                            .padding()    // Add padding inside the button
                            .frame(width: 75, height: 60) // Set a minimum size for the button
                            .background(Color.yellow) // Optional: Change the background color
                            .foregroundColor(.black) // Change text and icon color
                            .cornerRadius(10) // Round the corners of the button
                    }
                    .padding()
                    .sensoryFeedback(.increase, trigger: total)
                    
                    
                    Button {
                        withAnimation(.easeInOut(duration: 2.0)) {
                            total = 0
                            progressValue = 0
                        }
                    } label: {
                        Image(systemName: "restart.circle")
                            .padding()    // Add padding inside the button
                            .frame(width: 50, height: 40) // Set a minimum size for the button
                            .background(Color.yellow) // Optional: Change the background color
                            .foregroundColor(.black) // Change text and icon color
                            .cornerRadius(10) // Round the corners of the button
                    }
                    .padding()
                }
                
            }
            .padding()
        }
        .onAppear { checkIfNewDay() }
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
            progressValue = 0.0
            UserDefaults.standard.set(Date(), forKey: "lastAccessDate")
        } else {
            // Load the saved count for the current day
            total = UserDefaults.standard.integer(forKey: "total")
            let floatTotal = Float(total)
            progressValue = floatTotal / Float(upperBound)
        }
    }
}

#Preview {
    ContentView()
}
