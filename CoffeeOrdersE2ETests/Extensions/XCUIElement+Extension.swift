//
//  XCUIElement+Extension.swift
//  CoffeeOrdersE2ETests
//
//  Created by Alejandro Ignacio Aliaga Martinez on 22/12/22.
//

import XCTest

extension XCUIElement {
    
    func tapAndWaitForKeyboardToAppear() {
        let waitTime = 0.5
        let retryMaxCount = 20
        let keyboard = XCUIApplication().keyboards.element
        
        for _ in 0..<retryMaxCount {
          tap()
            if keyboard.waitForExistence(timeout: waitTime) {
                return
            }
        }
        
        XCTAssert(false, "keyboard failed to appear")
    }
    
}
