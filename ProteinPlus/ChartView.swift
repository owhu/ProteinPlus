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
    @State private var rawSelectedDate: Date?
    
    var last7DaysHistory: [ProteinRecord] {
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -6, to: Date()) ?? Date()
        return viewModel.proteinHistory.filter { $0.date >= sevenDaysAgo }
    }

    
    var selectedProteinRecord: ProteinRecord? {
        guard let rawSelectedDate else { return nil }
        return viewModel.proteinHistory.first {
            Calendar.current.isDate(rawSelectedDate, inSameDayAs: $0.date)
        }
    }
    
    var body: some View {
        if !viewModel.proteinHistory.isEmpty {
            VStack {
                Chart {
                    if let selectedProteinRecord {
                        RuleMark(x: .value("Selected Metric", selectedProteinRecord.date, unit: .day))
                            .foregroundStyle(Color.secondary.opacity(0.3))
                            .offset(y: -10)
                            .annotation(
                                position: .top,
                                spacing: 0,
                                overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) { annotationView }
                    }
                    
                    RuleMark(y: .value("Goal", viewModel.upperBound))
                        .foregroundStyle(Color.blue)
                        .lineStyle(StrokeStyle(lineWidth: 1/*, dash: [5]*/))
                    
                    ForEach(last7DaysHistory) { record in
                        BarMark(
//                            x: .value("Date", record.date.formatted(.dateTime.month().day())),
                            x: .value("Date", record.date, unit: .day),
                            y: .value("Protein", record.amount),
                            width: 20
                        )
                        .foregroundStyle(Color.yellow.gradient)
                        .opacity(rawSelectedDate == nil || record.date == selectedProteinRecord?.date ? 1.0 : 0.3)
                    }
                }
                .frame(height: 200)
//                .chartYScale(domain: 0...200)
//                .chartXScale(domain: Calendar.current.date(byAdding: .day, value: -6, to: Date())! ... Date())
//                .padding(.horizontal, 20)
                .chartXSelection(value: $rawSelectedDate.animation(.easeInOut))
                .chartXAxis {
                    AxisMarks {
                        AxisValueLabel(format: .dateTime.month(.defaultDigits).day())
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
            .padding()
        } else {
            Text("No history found")
        }
    }
    
    var annotationView: some View {
        VStack(alignment: .leading) {
            Text(selectedProteinRecord?.date ?? .now, format: .dateTime.weekday(.abbreviated).month(.abbreviated).day())
                .font(.footnote.bold())
                .foregroundStyle(.secondary)
            
            Text(selectedProteinRecord?.amount ?? 0, format: .number.precision(.fractionLength(0)))
                .fontWeight(.heavy)
                .foregroundStyle(.yellow)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: .secondary.opacity(0.3), radius: 2, x: 2, y: 2)
        )
    }

}

#Preview {
    ChartView()
}
