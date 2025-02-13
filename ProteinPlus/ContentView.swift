//
//  ContentView.swift
//  ProteinPlus
//
//  Created by Oliver Hu on 8/9/24.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                ProgressView(progress: self.$viewModel.progressValue)
                    .frame(width: 230.0, height: 230.0)
                    .padding(.top, 20)
                    .onAppear {
                        self.viewModel.progressValue = viewModel.progressValue
                    }
                VStack {
                    HStack {
                        if viewModel.total >= viewModel.upperBound {
                            Image(systemName: "checkmark.circle.fill")
                        }
                        Text("\(viewModel.total) g")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.top)
            }
            .padding(.top, 50)
            VStack {
                Button("Goal: \(viewModel.upperBound) g") {
                    viewModel.showingEditView = true
                }
                .font(.subheadline)
                .foregroundStyle(.gray)
                .sheet(isPresented: $viewModel.showingEditView) {
                    EditUpperBoundView(upperBound: $viewModel.upperBound)
                        .presentationDetents([.height(300)])
                }
                
                Text("Left: \(viewModel.remainingProtein) g")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            .padding()
            
            Spacer()
            
            
            Picker("Protein", selection: $viewModel.proteinAmount) {
                ForEach(1..<81) { amount in
                    Text("^[\(amount) gram](inflect: true)")
                        .tag(amount)
                }
            }
            .pickerStyle(.wheel)
            
            Spacer()
            
            
            VStack {
                Button {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        viewModel.addProtein()
                    }
                    
                } label: {
                    Image(systemName: "plus")
                        .modifier(StandardButtonModifier())
//                        .padding()    // Add padding inside the button
//                        .frame(width: 90, height: 60) // Set a minimum size for the button
//                        .background(.thinMaterial) // Optional: Change the background color
                        .foregroundColor(.blue) // Change text and icon color
//                        .cornerRadius(10) // Round the corners of the button
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 20)
//                                .stroke(Color.gray, lineWidth: 3)
//                        )
                }
               
                .sensoryFeedback(.increase, trigger: viewModel.total)
                
                HStack {
                    Button {
                        withAnimation(.easeInOut(duration: 1.5)) {
                            viewModel.resetProtein()
                        }
                    } label: {
                        Image(systemName: "restart.circle")
                            .modifier(StandardSmallButtonModifier())
                            .foregroundStyle(.gray)
//                            .padding()    // Add padding inside the button
//                            .frame(width: 160, height: 44) // Set a minimum size for the button
//                            .background(.thinMaterial) // Optional: Change the background color
//                            .foregroundColor(.gray) // Change text and icon color
//                            .cornerRadius(10) // Round the corners of the button
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 20)
//                                    .stroke(Color.gray, lineWidth: 3)
//                            )
                    }
                    
                    
                    
                    
                    Button {
                        withAnimation(.easeInOut(duration: 1.5)) {
                            viewModel.subtractProtein()
                        }
                    } label: {
                        Image(systemName: "minus")
                            .modifier(StandardSmallButtonModifier())
//                            .padding()    // Add padding inside the button
//                            .frame(width: 160, height: 44) // Set a minimum size for the button
//                            .background(.thinMaterial) // Optional: Change the background color
                            .foregroundColor(.red) // Change text and icon color
//                            .cornerRadius(10) // Round the corners of the button
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 20)
//                                    .stroke(Color.gray, lineWidth: 3)
//                            )
                    }
                    
                    .sensoryFeedback(.increase, trigger: viewModel.total)
                    

                }
                .padding()
            }
        }
        .onAppear { viewModel.checkIfNewDay() }
    }
    

}

#Preview {
    ContentView()
}
