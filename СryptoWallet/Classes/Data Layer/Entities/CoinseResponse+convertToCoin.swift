//
//  CoinseResponse+convertToCoin.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 18.11.2022.
//

import Foundation

extension CoinResponse {
    
    func convertToCoin() -> Coin? {
        guard let percentChangeUSD24h = marketData.percentChangeUSD24h?.rounded(toPlaces: 3) else { return nil }
        let coin = Coin(name: name,
                        priceUSD: marketData.priceUSD?.rounded(toPlaces: 3),
                        priceBTC: marketData.priceBTC?.rounded(toPlaces: 3),
                        priceETH: marketData.priceETH?.rounded(toPlaces: 3),
                        percentChangeUSD24h: percentChangeUSD24h)
        return coin
    }
}
