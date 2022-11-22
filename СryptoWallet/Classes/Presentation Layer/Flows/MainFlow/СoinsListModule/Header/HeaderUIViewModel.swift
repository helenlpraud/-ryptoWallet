//
//  HeaderUIViewModel.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 10.11.2022.
//

import UIKit

protocol HeaderUIViewModelProtocol {
    
    var menuModel: UIMenuModel { get set }
    var actionsModel: [UIActionModel] { get set }
}

final class HeaderUIViewModel: HeaderUIViewModelProtocol {

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

struct UIMenuModel {
    
    let title: String
}

struct UIActionModel {
    
    let title: String
    let didSelectAction: ((UIAction) -> Void)?
}
