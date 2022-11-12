//
//  CoinTableViewCellModel.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 07.11.2022.
//

class CoinTableViewCellModel {
    
    // MARK: Public Properties
    
    var name: String
    var priceUSD: String?
    var percentChangeUSD24h: String?
    
    // MARK: Initializer
    
    init(name: String, priceUSD: String?, percentChangeUSD24h: String?) {
        self.name = name
        self.priceUSD = priceUSD
        self.percentChangeUSD24h = percentChangeUSD24h
    }
}
