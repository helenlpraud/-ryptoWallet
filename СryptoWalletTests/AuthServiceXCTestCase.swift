//
//  AuthServiceXCTestCase.swift
//  СryptoWalletTests
//
//  Created by Shagaeva Elena on 21.12.2022.
//

import XCTest
@testable import СryptoWallet

final class AuthServiceXCTestCase: XCTestCase {
    
    var authStateProvider: AuthStateProvider!
    var authService: AuthServiceProtocol!

    override func setUpWithError() throws {
        let authService = AuthService()
        authService.storage = AuthStorage()
        authStateProvider = authService
        self.authService = authService
    }

    override func tearDownWithError() throws {
        authService = nil
        authStateProvider = nil
    }
    
    func testCheckAuthSuccessResult() throws {
        let expectedResultAuth = true
        var validateResultAuth: Bool
        
        authService.auth()
        validateResultAuth = authStateProvider.authState
        
        XCTAssertEqual(expectedResultAuth, validateResultAuth)
    }
    
    func testCheckAuthFailedResult() throws {
        let expectedResultAuth = false
        var validateResultAuth: Bool
        
        authService.logout()
        validateResultAuth = authStateProvider.authState
        
        XCTAssertEqual(expectedResultAuth, validateResultAuth)
    }
}
