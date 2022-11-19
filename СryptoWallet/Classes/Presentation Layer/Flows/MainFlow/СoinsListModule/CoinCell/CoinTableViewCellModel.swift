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
    var priceBTC: String?
    var percentChangeUSD24h: String?
    
    // MARK: Initializer
    
    init(name: String,
         priceUSD: String?,
         priceBTC: String?,
         percentChangeUSD24h: String?) {
        self.name = name
        self.priceUSD = priceUSD
        self.priceBTC = priceBTC
        self.percentChangeUSD24h = percentChangeUSD24h
    }
}
