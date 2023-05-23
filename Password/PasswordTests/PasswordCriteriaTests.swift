//
//  PasswordCriteriaTests.swift
//  PasswordTests
//
//  Created by Candi Chiu on 16.05.23.
//

import Foundation
import XCTest

@testable import Password

class PasswordLengthCriteriaTests: XCTestCase {
    
    // Boundary conditions 8-32
    
    func testShort() throws{ // 7
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("psFsj5k"))
    }
    
    func testLong() throws { // 33
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("Jtfa8XF1tysTuHQCBK1psDH3pWxz87qGh"))
    }
    
    func testValidShort() throws { // 8
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("BRGvo2jL"))
    }
    
    func testValidLong() throws { // 32
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("o6mTG5FjE0z1ydY8FJzw4tHikA5bk0Fe"))
    }
    
}

class PasswordOtherCriteriaTests: XCTestCase {
    
    func testSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet("BRGvo2jL"))
    }
    
    func testSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet("B RGvo2jL"))
    }
    
    func testLengthAndSpaceMet() throws {
        XCTAssertTrue(PasswordCriteria.lengthAndNoSpaceMet("BRGvo2jL"))
    }
    
    func testLengthAndSpaceNotMet() throws {
        XCTAssertFalse(PasswordCriteria.lengthAndNoSpaceMet("o6mTG5F  jE0z1ydY8FJzw4tHikA5bk0"))
    }
    
    func testUpperCaseMet() throws {
        XCTAssertTrue(PasswordCriteria.upperCaseCriteriaMet("A"))
    }
    
    func testUpperCaseNotMet() throws {
        XCTAssertFalse(PasswordCriteria.upperCaseCriteriaMet("a"))
    }
    
    func testLowerCaseMet() throws {
        XCTAssertTrue(PasswordCriteria.lowerCaseCriteriaMet("a"))
    }
    
    func testLowerCaseNotMet() throws {
        XCTAssertFalse(PasswordCriteria.lowerCaseCriteriaMet("A"))
    }
    
    func testDigitMet() throws {
        XCTAssertTrue(PasswordCriteria.digitCriteriaMet("1"))
    }
    
    func testDigitNotMet() throws {
        XCTAssertFalse(PasswordCriteria.digitCriteriaMet("a"))
    }
    
    func testSpecialCharMet() throws {
        XCTAssertTrue(PasswordCriteria.specialCharacterCriteriaMet("@"))
    }
    
    func testSpecialCharNotMet() throws {
        XCTAssertFalse(PasswordCriteria.specialCharacterCriteriaMet("a"))
    }
    
    
}
