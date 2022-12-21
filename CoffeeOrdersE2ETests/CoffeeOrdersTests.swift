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
    
    func testShouldDisplayCoffeeOrderInListSuccessfully() throws {
        // Arrange        
        // go to place order screen
        app.buttons["addNewOrderButton"].tap()
        
        // fill out the textfields
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]
        
        nameTextField.tap()
        nameTextField.typeText("John")
        
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Hot Coffee")
        
        priceTextField.tap()
        priceTextField.typeText("4.50")
        
        // Act
        // place the order
        placeOrderButton.tap()
        
        // Assert
        XCTAssertEqual("John", app.staticTexts["orderNameText"].label)
        XCTAssertEqual("Hot Coffee (Medium)", app.staticTexts["coffeeNameAndSizeText"].label)
        XCTAssertEqual("$4.50", app.staticTexts["coffeePriceText"].label)
    }

    func testDeletingAnOrder() throws {
        // Arrange
        // go to place order screen
        app.buttons["addNewOrderButton"].tap()
        
        // fill out the textfields
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]
        
        nameTextField.tap()
        nameTextField.typeText("John")
        
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Hot Coffee")
        
        priceTextField.tap()
        priceTextField.typeText("4.50")
                
        // place the order
        placeOrderButton.tap()
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        let cellsQuery = collectionViewsQuery.cells
        let element = cellsQuery.children(matching: .other)
            .element(boundBy: 1)
            .children(matching: .other)
            .element
                
        // Act
        // delete the order
        element.swipeLeft()
        collectionViewsQuery.buttons["Delete"].tap()
        
        // Assert
        let orderList = app.collectionViews["orderList"]
        XCTAssertEqual(0, orderList.cells.count)
    }
    
}
