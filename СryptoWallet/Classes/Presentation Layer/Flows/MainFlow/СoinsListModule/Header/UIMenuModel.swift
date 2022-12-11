//
//  UIMenuModel.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 11.12.2022.
//

import UIKit

struct UIMenuModel {
    let title: String
}

struct UIActionModel {
    let title: String
    let handler: ((UIAction) -> Void)?
}
