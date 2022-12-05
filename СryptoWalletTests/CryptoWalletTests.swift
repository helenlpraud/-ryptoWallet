//
//  _ryptoWalletTests.swift
//  СryptoWalletTests
//
//  Created by Shagaeva Elena on 05.12.2022.
//

import XCTest
@testable import СryptoWallet


final class _ryptoWalletTests: XCTestCase {
    
    var validationService: ValidationServiceProtocol!
    var authStateProvider: AuthStateProvider!
    var authService: AuthServiceProtocol!
    var processingInputService: ProcessingInputServiceProtocol!

    override func setUpWithError() throws {
        validationService = ValidationService()
        let authService = AuthService()
        authService.storage = AuthStorage()
        authStateProvider = authService
        self.authService = authService
        processingInputService = ProcessingInputService()
    }

    override func tearDownWithError() throws {
        validationService = nil
        authService = nil
        authStateProvider = nil
        processingInputService = nil
    }
    
    func testCheckStateForFilledPasswordAndLogin() throws {
        let login = "fff"
        let password = "ffff"
        let expectedResultAuth = StateInputAuth.fieldsAreFilled
        var validateResultAuth: StateInputAuth
        
        validateResultAuth = processingInputService.getStateInput(login: login, password: password)
        
        XCTAssertEqual(expectedResultAuth, validateResultAuth)
    }
    
    func testCheckStateForNotEmptyLoginAndEmptyPassword() throws {
        let login = "fff"
        let password = String()
        let expectedResultAuth = StateInputAuth.passwordFieldIsEmpty
        var validateResultAuth: StateInputAuth
        
        validateResultAuth = processingInputService.getStateInput(login: login, password: password)
        
        XCTAssertEqual(expectedResultAuth, validateResultAuth)
    }
    
    func testCheckStateForEmptyLoginAndEmptyPassword() throws {
        let login = String()
        let password = String()
        let expectedResultAuth = StateInputAuth.fieldsAreEmpty
        var validateResultAuth: StateInputAuth
        
        validateResultAuth = processingInputService.getStateInput(login: login, password: password)
        
        XCTAssertEqual(expectedResultAuth, validateResultAuth)
    }
    
    func testCheckStateForEmptyLoginAndNotEmptyPassword() throws {
        let login = String()
        let password = "dsdk"
        let expectedResultAuth = StateInputAuth.loginIsEmpty
        var validateResultAuth: StateInputAuth
        
        validateResultAuth = processingInputService.getStateInput(login: login, password: password)
        
        XCTAssertEqual(expectedResultAuth, validateResultAuth)
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

    func testValidationWithEmptyValues() throws {
        let login = String()
        let password = String()
        let expectedResult = ResultCheking((false, .invalidData))
        var validateResult: ResultCheking
        
        validateResult = validationService.checkAuthData(currentLogin: login, currentPswd: password)
        
        XCTAssertEqual(expectedResult?.isSuccessChecked, validateResult?.isSuccessChecked)
        XCTAssertEqual(expectedResult?.errorType, validateResult?.errorType)
    }
    
    func testValidationWithIncorrectLoginAndPassword() throws {
        let login = "fhhfdfj"
        let password = "1dsf"
        let expectedResult = ResultCheking((false, .invalidData))
        var validateResult: ResultCheking
        
        validateResult = validationService.checkAuthData(currentLogin: login, currentPswd: password)
        
        XCTAssertEqual(expectedResult?.isSuccessChecked, validateResult?.isSuccessChecked)
        XCTAssertEqual(expectedResult?.errorType, validateResult?.errorType)
    }
    
    func testValidationWithCorrectLoginAndPassword() throws {
        let login = "User"
        let password = "123"
        let expectedResult = ResultCheking((true, nil))
        var validateResult: ResultCheking
        
        validateResult = validationService.checkAuthData(currentLogin: login, currentPswd: password)
        
        XCTAssertEqual(expectedResult?.isSuccessChecked, validateResult?.isSuccessChecked)
        XCTAssertEqual(expectedResult?.errorType, validateResult?.errorType)
    }
    
    func testValidationWithCorrectLoginAndNotCorrectPassword() throws {
        let login = "User"
        let password = "falsePwd"
        let expectedResult = ResultCheking((false, .invalidPwd))
        var validateResult: ResultCheking
        
        validateResult = validationService.checkAuthData(currentLogin: login, currentPswd: password)
        
        XCTAssertEqual(expectedResult?.isSuccessChecked, validateResult?.isSuccessChecked)
        XCTAssertEqual(expectedResult?.errorType, validateResult?.errorType)
    }
    
    func testValidationWithNotCorrectLoginAndCorrectPassword() throws {
        let login = "falseUser"
        let password = "123"
        let expectedResult = ResultCheking((false, .invalidLogin))
        var validateResult: ResultCheking
        
        validateResult = validationService.checkAuthData(currentLogin: login, currentPswd: password)
        
        XCTAssertEqual(expectedResult?.isSuccessChecked, validateResult?.isSuccessChecked)
        XCTAssertEqual(expectedResult?.errorType, validateResult?.errorType)
    }
}
