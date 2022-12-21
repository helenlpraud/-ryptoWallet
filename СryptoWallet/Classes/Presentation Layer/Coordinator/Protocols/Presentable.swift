//
//  Presentable.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 15.11.2022.
//

import UIKit

protocol Presentable {

    var toPresent: UIViewController? { get }
}

extension UIViewController: Presentable {

    var toPresent: UIViewController? {
        return self
    }
}
