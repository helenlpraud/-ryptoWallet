//
//  ValidationServiceXCTestCase.swift
//  СryptoWalletTests
//
//  Created by Shagaeva Elena on 21.12.2022.
//

import XCTest
@testable import СryptoWallet

final class ValidationServiceXCTestCase: XCTestCase {
    
    var validationService: ValidationServiceProtocol!

    override func setUpWithError() throws {
        validationService = ValidationService()
    }

    override func tearDownWithError() throws {
        validationService = nil
    }
    
    func testValidationWithEmptyValues() throws {
        let login = String()
        let password = String()
        let expectedResult = ResultCheking((false, .invalidInput))
        var validateResult: ResultCheking
        
        validateResult = validationService.checkAuthData(currentLogin: login, currentPswd: password)
        
        XCTAssertEqual(expectedResult?.isSuccessChecked, validateResult?.isSuccessChecked)
        XCTAssertEqual(expectedResult?.errorType, validateResult?.errorType)
    }
    
    func testValidationWithIncorrectLoginAndPassword() throws {
        let login = "fhhfdfj"
        let password = "1dsf"
        let expectedResult = ResultCheking((false, .invalidInput))
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
