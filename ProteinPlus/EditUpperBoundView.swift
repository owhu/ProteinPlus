//
//  EditUpperBoundView.swift
//  ProteinPlus
//
//  Created by Oliver Hu on 9/12/24.
//

import SwiftUI

struct EditUpperBoundView: View {
    @Binding var upperBound: Int
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                //            Stepper(value: $upperBound, in: 0...120) {
                //                Text("Goal: \(upperBound) g")
                //                    .font(.headline)
                //            }
                Picker("Goal: \(upperBound) g", selection: $upperBound) {
                    ForEach(1..<120) { amount in
                        Text("^[\(amount) gram](inflect: true)")
                            .tag(amount)
                    }
                }
                .pickerStyle(.wheel)
            }
            .padding()
            .navigationTitle("Edit Goal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                }
            }
        }
    }
}

//#Preview {
//    EditUpperBoundView(upperBound: 80)
//}
