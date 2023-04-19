//
//  AccountSummaryViewControllerTests.swift
//  BankyUnitTests
//
//  Created by Candi Chiu on 18.04.23.
//

import Foundation
import XCTest

@testable import Banky

class AccountSummaryViewControllerTests: XCTestCase {
    var vc: AccountSummaryViewController!
    var mockManager: MockProfileManager!
    
    class MockProfileManager: ProfileManagable {
        var profile: Profile?
        var error: NetworkError?
        
        func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
            if error != nil {
                completion(.failure(error!))
                return
            }
            
            profile = Profile(id: "1", firstName: "First name", lastName: "Last name")
            completion(.success(profile!))
        }
    }
    
    
    override func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
    //    vc.loadViewIfNeeded(), this will trigger viewDidLoad / viewDidAppear..etc
        mockManager = MockProfileManager()
        vc.profileManager = mockManager
    }
    
    func testTitleAndMessageForServerError() throws {
        let titleAndMessge = vc.titleAndMessageForTesting(for: .serverError)
        XCTAssertEqual("Server Error", titleAndMessge.0)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", titleAndMessge.1)
        
    }
    
    func testTitleAndMessageForDecodingError() throws {
        let titleAndMessge = vc.titleAndMessageForTesting(for: .decodingError)
        XCTAssertEqual("Network Error", titleAndMessge.0)
        XCTAssertEqual("We could not process your request. Please try again.",titleAndMessge.1)
        
    }
    
    func testAlertForServerError() throws {
        mockManager.error = .serverError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Server Error", vc.errorAlert.title)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", vc.errorAlert.message)
    }
    
    func testAlertForDecodingError() throws {
        mockManager.error = .decodingError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Network Error", vc.errorAlert.title)
        XCTAssertEqual("We could not process your request. Please try again.", vc.errorAlert.message)
    }
    
}
