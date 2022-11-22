//
//  Coordinator.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 15.11.2022.
//

import Foundation

protocol Coordinator: AnyObject {

    var router: Routable { get }

    func start()
}
