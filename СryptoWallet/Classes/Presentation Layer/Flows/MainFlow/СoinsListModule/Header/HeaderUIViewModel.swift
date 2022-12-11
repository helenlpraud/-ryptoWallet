//
//  HeaderUIViewModel.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 10.11.2022.
//

protocol HeaderUIViewModelProtocol {
    
    var menuModel: UIMenuModel { get set }
    var actionsModel: [UIActionModel] { get set }
    
    var didChangeStateHeader: ((StateHeader) -> (Void))? { get set }
}

final class HeaderUIViewModel: HeaderUIViewModelProtocol {
    
    // MARK: Public Properties
    
    var didChangeStateHeader: ((StateHeader) -> (Void))?

    var menuModel: UIMenuModel
    var actionsModel: [UIActionModel]
    var buttonHeigh = 50.0
    var buttonWidth = 50.0
    
    // MARK: Initializer

    init(menuModel: UIMenuModel,
         actionsModel: [UIActionModel]) {
        self.menuModel = menuModel
        self.actionsModel = actionsModel
    }
    
    func changeStateHeader(stateHeader: StateHeader) {
        didChangeStateHeader?(stateHeader)
    }
}
