//
//  ContentViewModelTests.swift
//  ProteinPlusTests
//
//  Created by Oliver Hu on 12/4/24.
//

import XCTest

@testable import ProteinPlus

//final class ContentViewModelTests: XCTestCase {
//
//    func testSuccessfulAddition() {
//        // Arrange
//        
//        let viewModel = ContentViewModel()
//        viewModel.total = 50
//        viewModel.progressValue = 0.5
//        viewModel.proteinAmount = 20
//        viewModel.upperBound = 100
//        
//        // Act
//        viewModel.addProtein()
//        
//        // Assert
//        XCTAssertEqual(viewModel.total, 70)
//        XCTAssertEqual(viewModel.progressValue, 0.7)
//    }
//
//    func testSuccessfulSubtraction() {
//        // Arrange
//        
//        let viewModel = ContentViewModel()
//        viewModel.total = 50
//        viewModel.progressValue = 0.5
//        viewModel.proteinAmount = 20
//        viewModel.upperBound = 100
//        
//        // Act
//        viewModel.subtractProtein()
//        
//        // Assert
//        XCTAssertEqual(viewModel.total, 30)
//        XCTAssertEqual(viewModel.progressValue, 0.3)
//    }
//}

class ContentViewModelTests: XCTestCase {
    
    var viewModel: ContentViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ContentViewModel()
    }
    
    // MARK: - Add Protein Tests
    
    func testAddProtein() {
        // Arrange
        viewModel.proteinAmount = 20
        viewModel.upperBound = 100
        
        // Act
        viewModel.addProtein()
        
        // Assert
        XCTAssertEqual(viewModel.total, 20)
        XCTAssertEqual(viewModel.progressValue, 0.2, accuracy: 0.001)
    }
    
    func testAddProteinMultipleTimes() {
        // Arrange
        viewModel.proteinAmount = 10
        viewModel.upperBound = 50
        
        // Act
        viewModel.addProtein()
        viewModel.addProtein()
        
        // Assert
        XCTAssertEqual(viewModel.total, 20)
        XCTAssertEqual(viewModel.progressValue, 0.4, accuracy: 0.001)
    }
    
    // MARK: - Reset Protein Tests
    
    func testResetProtein() {
        // Arrange
        viewModel.proteinAmount = 30
        viewModel.upperBound = 90
        viewModel.addProtein() // Add some initial value
        
        // Act
        viewModel.resetProtein()
        
        // Assert
        XCTAssertEqual(viewModel.total, 0)
        XCTAssertEqual(viewModel.progressValue, 0.0, accuracy: 0.001)
    }
    
    // MARK: - Subtract Protein Tests
    
    func testSubtractProteinWhenAvailable() {
        // Arrange
        viewModel.proteinAmount = 20
        viewModel.upperBound = 100
        viewModel.addProtein() // Add initial 20
        
        // Act
        viewModel.subtractProtein()
        
        // Assert
        XCTAssertEqual(viewModel.total, 0)
        XCTAssertEqual(viewModel.progressValue, 0.0, accuracy: 0.001)
    }
    
    func testSubtractProteinWhenNotEnoughAvailable() {
        // Arrange
        viewModel.proteinAmount = 30
        viewModel.upperBound = 100
        viewModel.addProtein() // Add initial 30
        viewModel.proteinAmount = 40 // Try to subtract more than available
        
        // Act
        viewModel.subtractProtein()
        
        // Assert
        XCTAssertEqual(viewModel.total, 30) // Should remain unchanged
        XCTAssertEqual(viewModel.progressValue, 0.3, accuracy: 0.001)
    }
}
