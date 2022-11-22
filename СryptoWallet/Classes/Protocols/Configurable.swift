//
//  Configurable.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 22.11.2022.
//

protocol Configurable {
    
    associatedtype ViewModel
    
    func configure(with model: ViewModel)
}
