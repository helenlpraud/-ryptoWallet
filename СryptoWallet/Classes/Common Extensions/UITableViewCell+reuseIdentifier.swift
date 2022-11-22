//
//  UITableViewCell+reuseIdentifier.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 21.11.2022.
//

import UIKit


extension UITableViewCell {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }

    var reuseIdentifier: String {
        type(of: self).reuseIdentifier
    }
}
