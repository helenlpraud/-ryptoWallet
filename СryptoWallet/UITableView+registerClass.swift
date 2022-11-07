//
//  UITableView+registerClass.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 07.11.2022.
//

import UIKit

public extension UITableView {
    
    func registerCellClass(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        
        register(cellClass, forCellReuseIdentifier: identifier)
    }
}
