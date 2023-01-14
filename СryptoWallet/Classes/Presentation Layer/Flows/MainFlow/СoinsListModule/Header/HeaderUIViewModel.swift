//
//  HeaderUIViewModel.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 10.11.2022.
//

protocol HeaderUIViewModelProtocol {
    
    var menuModel: MenuModel { get set }
    var actionsModel: [ActionModel] { get set }
    
    var didChangeStateHeader: ((StateHeader) -> (Void))? { get set }
}

final class HeaderUIViewModel: HeaderUIViewModelProtocol {
    
    // MARK: Public Properties
    
    var didChangeStateHeader: ((StateHeader) -> (Void))?

    var menuModel: MenuModel
    var actionsModel: [ActionModel]
    var buttonHeigh = 50.0
    var buttonWidth = 50.0
    
    // MARK: Initializer

    init(menuModel: MenuModel,
         actionsModel: [ActionModel]) {
        self.menuModel = menuModel
        self.actionsModel = actionsModel
    }
    
    func changeStateHeader(stateHeader: StateHeader) {
        didChangeStateHeader?(stateHeader)
    }
}
