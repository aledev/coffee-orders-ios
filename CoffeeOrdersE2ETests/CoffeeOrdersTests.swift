//
//  CoffeeOrdersE2ETests.swift
//  CoffeeOrdersE2ETests
//
//  Created by Alejandro Ignacio Aliaga Martinez on 21/12/22.
//

import XCTest

@MainActor
final class AppLaunchWithNoOrdersTests: XCTestCase {
    // MARK: - Properties
    private var app: XCUIApplication!
    
    // MARK: - Setup
    private func clearData() async {
        // Delete Items
        guard let url = URL(string: "/test/clear-orders",
                            relativeTo: URL(string: "https://coffee-orders-backend.herokuapp.com")!) else {
            return
        }
        
        _ = try? await URLSession.shared.data(from: url)
    }
    
    override func setUp() async throws {
        self.app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "QA"]
        app.launch()
                
        await clearData()
    }
    
    override func tearDown() async throws {
        await clearData()
    }
    
    // MARK: - Tests
    func testShouldMakeSureNoOrdersMessagesIsDisplayed() throws {
        // UI tests must launch the application that they test.
        // Assert
        XCTAssertEqual("No orders available!", app.staticTexts["noOrdersText"].label)        
    }

}
