//
//  ContentViewModel.swift
//  ProteinPlus
//
//  Created by Oliver Hu on 12/4/24.
//

import Foundation
import SwiftUI

final class ContentViewModel: ObservableObject {
    
    @AppStorage("total") var total = 0
    @AppStorage("upperBound") var upperBound = 90
    
    @Published var proteinAmount = 1
    @Published var progressValue: Float = 0.0
    @Published var showingEditView = false
    
    var remainingProtein: Int {
        upperBound - total
    }
    
    func addProtein() {
        total += proteinAmount
        progressValue += (Float(proteinAmount)) / Float(upperBound)
    }
    
    func resetProtein() {
        total = 0
        progressValue = 0
    }
    
    func subtractProtein() {
        if total >= proteinAmount {
            total -= proteinAmount
            progressValue -= (Float(proteinAmount)) / Float(upperBound)
        }
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
