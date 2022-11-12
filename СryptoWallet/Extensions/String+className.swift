//
//  String+className.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 11.11.2022.
//

import Foundation

public extension String {

    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last ?? ""
    }
}
