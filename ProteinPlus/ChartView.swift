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
                RuleMark(y: .value("Goal", viewModel.upperBound))
                    .foregroundStyle(Color.mint)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                
                ForEach(viewModel.proteinHistory) { record in
                    BarMark(
                        x: .value("Date", record.date, unit: .day),
                        y: .value("Protein", record.amount)
                    )
                    .foregroundStyle(Color.pink.gradient)
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
