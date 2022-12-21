//
//  AlertPresentationServiceXCTestCase.swift
//  СryptoWalletTests
//
//  Created by Shagaeva Elena on 21.12.2022.
//

import XCTest
@testable import СryptoWallet

final class AlertPresentationServiceXCTestCase: XCTestCase {
    
    var alertPresentationService: AlertPresentationServiceProtocol!

    override func setUpWithError() throws {
        alertPresentationService = AlertPresentationService()
    }

    override func tearDownWithError() throws {
        alertPresentationService = nil
    }
    
    func testShowAlertInvalidLogin() throws {
        let error = ErrorType.invalidLogin
        let title: String = ""
        let message: String = StringsAuth.invalidLogin
        let actions: [Action] = [Action(title: StringsAuth.actionTitle, style: .standart)]
        let extectedResultModel = AlertModel(title: title, message: message, actions: actions)
        var validateResultModel: AlertModel
        
        validateResultModel = alertPresentationService.showAlert(errorType: error)
        
        XCTAssertEqual(extectedResultModel, validateResultModel)
    }
    
    func testShowAlertInvalidPwd() throws {
        let error = ErrorType.invalidPwd
        let title: String = ""
        let message: String = StringsAuth.invalidPwd
        let actions: [Action] = [Action(title: StringsAuth.actionTitle, style: .standart)]
        let extectedResultModel = AlertModel(title: title, message: message, actions: actions)
        var validateResultModel: AlertModel
        
        validateResultModel = alertPresentationService.showAlert(errorType: error)
        
        XCTAssertEqual(extectedResultModel, validateResultModel)
    }
    
    func testShowAlertInvalidInput() throws {
        let error = ErrorType.invalidInput
        let title: String = ""
        let message: String = StringsAuth.invalidInput
        let actions: [Action] = [Action(title: StringsAuth.actionTitle, style: .standart)]
        let extectedResultModel = AlertModel(title: title, message: message, actions: actions)
        var validateResultModel: AlertModel
        
        validateResultModel = alertPresentationService.showAlert(errorType: error)
        
        XCTAssertEqual(extectedResultModel, validateResultModel)
    }
}
