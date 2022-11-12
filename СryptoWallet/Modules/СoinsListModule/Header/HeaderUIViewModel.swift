//
//  HeaderUIViewModel.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 10.11.2022.
//

import UIKit

struct UIMenuModel {
    
    let title: String
}

struct UIActionModel {
    
    let title: String
    let didSelectAction: ((UIAction) -> Void)?
}

class HeaderUIViewModel {

    var menuModel: UIMenuModel
    var actionsModel: [UIActionModel]
    var buttonHeigh = 50.0
    var buttonWidth = 50.0

    init(menuModel: UIMenuModel,
         actionsModel: [UIActionModel]) {
        self.menuModel = menuModel
        self.actionsModel = actionsModel
    }
}
