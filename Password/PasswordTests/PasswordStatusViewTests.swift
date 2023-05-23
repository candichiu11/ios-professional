//
//  PasswordStatusViewTests.swift
//  PasswordTests
//
//  Created by Candi Chiu on 16.05.23.
//

import Foundation
import XCTest

@testable import Password

class PasswordStatusViewTests_ShowCheckmarkOrReset_When_Validation_Is_Inline: XCTestCase {
    
    var statusView: PasswordStatusView!
    let validPassword = "BRGvo2jL"
    let tooShortPassword = "BR"
    
    
    override func setUp() { // This function gets called once per test.
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = true // inline
       
    }
    
    /*
         if shouldResetCriteria {
             // Inline validation (✅ or ⚪️)
         } else {
             ...
         }
    */
    
    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckmarkImage())
    }
    
    func testTooShortPassword() throws {
        statusView.updateDisplay(tooShortPassword)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCirleImage())
    }
    
}

class PasswordStatusViewTests_ShowCheckmarkOrRedX_When_Validation_Is_Loss_Of_Focus: XCTestCase {
    var statusView: PasswordStatusView!
    let validPassword = "BRGvo2jL"
    let tooShortPassword = "BR"
    
    
    override func setUp() { // This function gets called once per test.
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = false // loss of focus
    }
    
    /*
         if shouldResetCriteria {
             ...
         } else {
             // Focus lost (✅ or ❌)
         }
    */

    
    func testValidPassword() {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckmarkImage()) // ✅
    }
    
    func testTooShortPassword() {
        statusView.updateDisplay(tooShortPassword)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isXmarkImage()) // ❌
    }
    
}

class PasswordStatusViewTests_Validate_Three_Of_FourCriteria: XCTestCase {
    
    var statusView: PasswordStatusView!
    let fourMetPassword = "BRGvo2jL@"
    let oneMetPassword = "BRBRBRBR"
    let twoMetPassword = "BRBRBRbr"
    let threeMetPassword = "BRBRB4br"
    
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
    }
    
    func testFourCriteriaMet() {
        XCTAssertTrue(statusView.validate(fourMetPassword))
    }
    
    func testOnlyOneCriteriaMet() {
        XCTAssertFalse(statusView.validate(oneMetPassword))
    }
    
    func testOnlyTwoCriteriaMet() {
        XCTAssertFalse(statusView.validate(twoMetPassword))
    }
    
    func testOnlyThreeCriteriaMet() {
        XCTAssertTrue(statusView.validate(threeMetPassword))
    }
}
