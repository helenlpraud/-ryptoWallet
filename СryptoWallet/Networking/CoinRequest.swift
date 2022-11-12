//
//  CoinRequest.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 09.11.2022.
//

import Foundation

struct CoinRequest {
    
    // MARK: Public Properties
    
    let typeCoin: TypeCoin
    
    var path: String {
        switch typeCoin {
        case .btc:
            return "assets/btc/metrics"
        case .eth:
            return "assets/eth/metrics"
        case .tron:
            return "assets/tron/metrics"
        case .luna:
            return "assets/luna/metrics"
        case .polkadot:
            return "assets/polkadot/metrics"
        case .dogecoin:
            return "assets/dogecoin/metrics"
        case .tether:
            return "assets/tether/metrics"
        case .stellar:
            return "assets/stellar/metrics"
        case .cardano:
            return "assets/cardano/metrics"
        }
    }
}

enum TypeCoin {
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
