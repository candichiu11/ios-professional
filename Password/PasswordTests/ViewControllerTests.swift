//
//  ViewControllerTests.swift
//  PasswordTests
//
//  Created by Candi Chiu on 17.05.23.
//

import Foundation
import XCTest

@testable import Password

class ViewControllerTests_NewPassword_Validation: XCTestCase {
    
    var vc: ViewController!
    let validPassword = "BRGvo2jL@"
    let invalidPassword = "❤️" // ctrl + cmd + space > to access emoji
    let criteriaNotMetPassword = "BRG2L"
    let tooShortPassword = "BR"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testEmptyPassword() throws {
        vc.newPasswordText = ""
        vc.resetPasswordButtonTapped(sender: UIButton())
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text, "Enter your password")
    }
    
    func testCriteriaNotMet() throws {
        vc.newPasswordText = criteriaNotMetPassword
        vc.resetPasswordButtonTapped(sender: UIButton())
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text, "Your password must meet the requirements below")
    }
    
    func testValidPassword() throws {
        vc.newPasswordText = validPassword
        vc.resetPasswordButtonTapped(sender: UIButton())
        XCTAssertTrue(vc.newPasswordTextField.errorLabel.text == "")
    }
    
    func testInvalidPassword() throws {
        vc.newPasswordText = invalidPassword
        vc.resetPasswordButtonTapped(sender: UIButton())
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
    }
    
}

class ViewControllerTests_ConfirmPassword_Validation: XCTestCase {
    
    var vc: ViewController!
    let validPassword = "BRGvo2jL@"
    let tooShortPassword = "BR"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testEmptyPassword() throws {
        vc.confirmPasswordText = ""
        vc.resetPasswordButtonTapped(sender: UIButton())
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text, "Enter your password")
    }
    
    func testPasswordsMatch() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = validPassword
        vc.resetPasswordButtonTapped(sender: UIButton())
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "")
    }
    
    func testPasswordsDoNotMatch() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = tooShortPassword
        vc.resetPasswordButtonTapped(sender: UIButton())
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text, "Passwords do not match.")
    }
    
}

class ViewControllerTests_Show_Alert: XCTestCase {
    
    var vc: ViewController!
    let validPassword = "BRGvo2jL@"
    let tooShortPassword = "BR"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testShowSuccess() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = validPassword
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertNotNil(vc.alert)
        XCTAssertEqual(vc.alert?.title, "Success")
    }
    
    func testShowError() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = tooShortPassword
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertNil(vc.alert)
    }
}
