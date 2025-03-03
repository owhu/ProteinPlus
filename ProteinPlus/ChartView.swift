//
//  ChartView.swift
//  ProteinPlus
//
//  Created by Oliver Hu on 2/28/25.
//

import SwiftUI
import Charts

struct ChartView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        if !viewModel.proteinHistory.isEmpty {
            Chart {
                ForEach(viewModel.proteinHistory) { record in
                    BarMark(
                        x: .value("Date", record.date, unit: .day),
                        y: .value("Protein", record.amount)
                    )
                    .foregroundStyle(Color.blue.gradient)
                }
            }
            .frame(height: 200)
            .padding()
        } else {
            Text("No history found")
        }
    }
}

#Preview {
    ChartView()
}
