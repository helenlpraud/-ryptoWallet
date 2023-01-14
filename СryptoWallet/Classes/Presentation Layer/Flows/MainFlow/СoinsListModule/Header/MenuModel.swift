//
//  UIMenuModel.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 11.12.2022.
//

import UIKit

struct MenuModel {
    let title: String
}

struct ActionModel {
    let title: String
    let handler: ((UIAction) -> Void)?
}
