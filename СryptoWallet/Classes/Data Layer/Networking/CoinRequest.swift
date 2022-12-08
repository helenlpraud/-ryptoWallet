//
//  CoinRequest.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 09.11.2022.
//

struct CoinRequest {
    
    // MARK: Public Properties
    
    let typeCoin: TypeCoin
    
    var path: String {
        path(typeCoin: typeCoin)
    }
    
    private func path(typeCoin: TypeCoin) -> String {
        return "assets/\(typeCoin.rawValue)/metrics"
    }
}

enum TypeCoin: String,
               CaseIterable {
    case btc
    case eth
    case tron
    case luna
    case polkadot
    case dogecoin
    case tether
    case stellar
    case cardano
}
