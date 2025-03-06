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
            VStack {
                Chart {
                    RuleMark(y: .value("Goal", viewModel.upperBound))
                        .foregroundStyle(Color.blue)
                        .lineStyle(StrokeStyle(lineWidth: 1/*, dash: [5]*/))
                    
                    ForEach(viewModel.proteinHistory) { record in
                        BarMark(
                            x: .value("Date", record.date.formatted(.dateTime.month().day())),
//                            x: .value("Date", record.date, unit: .day),
                            y: .value("Protein", record.amount),
                            width: 20
                        )
                        .foregroundStyle(Color.yellow.gradient)
                    }
                }
                .frame(height: 200)
                .chartYScale(domain: 0...200)
//                .chartXAxis {
//                    AxisMarks(position: .bottom, values: viewModel.proteinHistory.map { $0.date}) { date in
//                        AxisValueLabel(format: .dateTime.month().day(), anchor: .center)
//                    }
//                }
                .chartXAxis {
                    AxisMarks(position: .bottom) { _ in
                        AxisValueLabel(anchor: .center) // Ensure label is centered
                        AxisTick()
                    }
                }
                .padding(.bottom)
                
                HStack {
                    Image(systemName: "line.diagonal")
                        .rotationEffect(Angle(degrees: 45))
                        .foregroundColor(.blue)
                    
                    Text("Daily Goal")
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                .font(.caption2)
                .padding(.leading, 4)
            }
        } else {
            Text("No history found")
        }
    }
}

#Preview {
    ChartView()
}
