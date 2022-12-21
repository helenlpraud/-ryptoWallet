//
//  ProcessingInputServiceXCTestCase.swift
//  СryptoWalletTests
//
//  Created by Shagaeva Elena on 21.12.2022.
//

import XCTest
@testable import СryptoWallet

final class ProcessingInputServiceXCTestCase: XCTestCase {

    var processingInputService: ProcessingInputServiceProtocol!

    override func setUpWithError() throws {
        processingInputService = ProcessingInputService()
    }

    override func tearDownWithError() throws {
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
}
