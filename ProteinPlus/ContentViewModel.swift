//
//  ContentViewModel.swift
//  ProteinPlus
//
//  Created by Oliver Hu on 12/4/24.
//

import Foundation
import SwiftUI

struct ProteinRecord: Identifiable, Codable {
    var id = UUID()
    let date: Date
    let amount: Int
}

final class ContentViewModel: ObservableObject {
    
    @AppStorage("total") var total = 0
    @AppStorage("upperBound") var upperBound = 90
    
    @Published var proteinAmount = 1
    @Published var showingEditView = false
    @Published var proteinHistory: [ProteinRecord] = []
    
    @Published var progressValue: Float = 0.0
    
    var remainingProtein: Int {
        upperBound - total
    }
    
    init() {
        loadProteinHistory()
        checkIfNewDay()
        updateProgress()
    }
    
    func addProtein() {
        total += proteinAmount
        checkIfNewDay()
        updateProgress()
    }
    
    func resetProtein() {
        total = 0
        updateProgress()
    }
    
    func subtractProtein() {
        if total >= proteinAmount {
            total -= proteinAmount
            checkIfNewDay()
            updateProgress()
        }
    }
    
    func updateProgress() {
        progressValue = Float(total) / Float(upperBound)
    }
    
    func checkIfNewDay() {
        let calendar = Calendar.current
        let today = Date()
        
        if let lastDate = UserDefaults.standard.object(forKey: "lastDate") as? Date {
            if !calendar.isDate(lastDate, inSameDayAs: today) {
                let newRecord = ProteinRecord(date: lastDate, amount: total)
                proteinHistory.append(newRecord)
                
                if proteinHistory.count > 7 {
                    proteinHistory.removeFirst(proteinHistory.count - 7)
                }
                
                saveProteinHistory()
                
                total = 0
            }
        }
        
        UserDefaults.standard.set(today, forKey: "lastDate")
    }
    
    private func loadProteinHistory() {
        if let data = UserDefaults.standard.data(forKey: "proteinHistory"),
           let history = try? JSONDecoder().decode([ProteinRecord].self, from: data) {
            proteinHistory = history
        }
    }
    
    private func saveProteinHistory() {
        if let encoded = try? JSONEncoder().encode(proteinHistory) {
            UserDefaults.standard.set(encoded, forKey: "proteinHistory")
        }
    }
    
}
